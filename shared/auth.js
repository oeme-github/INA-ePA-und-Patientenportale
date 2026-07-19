// shared/auth.js — gemeinsame Authentifizierung für viewer-db und editor-db (T08).
//
// Magic-Link zuerst (siehe KONTEXT.md, "Architekturentscheidung Multi-User-
// Web-Tool": E-Mail/Magic-Link als Einstieg, institutionelles SSO später).
// Passwort bleibt als Fallback verfügbar (Test-/Demo-Zugänge, s. supabase/README.md).
//
// Erwartet:
// - GOTRUE_URL als globale Konstante, von der einbindenden Seite VOR dem
//   Aufruf der Funktionen definiert (Auswertung erst zur Laufzeit, daher ist
//   die Reihenfolge der <script>-Tags unkritisch).
// - Ein Element <div id="login-screen"> im DOM, dessen Inhalt initLoginScreen()
//   befüllt, sowie <div id="app"> für die eigentliche Anwendung.

function getToken() { return sessionStorage.getItem('access_token'); }
function getUserEmail() { return sessionStorage.getItem('user_email'); }

function decodeJwt(token) {
  const payload = token.split('.')[1].replace(/-/g, '+').replace(/_/g, '/');
  const padded = payload + '='.repeat((4 - payload.length % 4) % 4);
  return JSON.parse(atob(padded));
}

function storeSession(json) {
  sessionStorage.setItem('access_token', json.access_token);
  sessionStorage.setItem('user_email', json.user?.email || decodeJwt(json.access_token).email || '');
}

function logout() {
  sessionStorage.removeItem('access_token');
  sessionStorage.removeItem('user_email');
  sessionStorage.removeItem('pending_email');
  document.getElementById('app').style.display = 'none';
  document.getElementById('login-screen').style.display = 'flex';
}

async function loginWithPassword(email, password) {
  const res = await fetch(`${GOTRUE_URL}/token?grant_type=password`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ email, password }),
  });
  const json = await res.json();
  if (!res.ok) throw new Error(json.error_description || json.msg || 'Anmeldung fehlgeschlagen');
  storeSession(json);
  return json;
}

async function requestMagicLink(email) {
  const res = await fetch(`${GOTRUE_URL}/otp`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ email, create_user: false }),
  });
  if (!res.ok) {
    const json = await res.json().catch(() => ({}));
    throw new Error(json.error_description || json.msg || 'Magic-Link konnte nicht angefragt werden');
  }
  sessionStorage.setItem('pending_email', email);
}

async function verifyMagicLinkCode(code) {
  const email = sessionStorage.getItem('pending_email');
  if (!email) throw new Error('Keine E-Mail-Adresse für die Bestätigung gefunden — Magic-Link erneut anfordern.');
  const res = await fetch(`${GOTRUE_URL}/verify`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ type: 'magiclink', email, token: code }),
  });
  const json = await res.json();
  if (!res.ok) throw new Error(json.error_description || json.msg || 'Code ungültig oder abgelaufen');
  storeSession(json);
  sessionStorage.removeItem('pending_email');
  return json;
}

// ── Institutionelles SSO (T10, Kandidat Microsoft Entra ID) ─────────
// GoTrue unterstützt Entra ID als externen OAuth-Provider fertig (Azure AD
// v2-Endpoint) — siehe supabase/docker-compose.yml (GOTRUE_EXTERNAL_AZURE_*)
// und supabase/.env.example. Was hier fehlt und NICHT lokal nachgebaut werden
// kann: eine App-Registrierung im tatsächlichen Entra-ID-Tenant der
// Organisation (Client-ID/-Secret, erlaubte Redirect-URIs) — das erfordert
// Zugriff auf den Azure-AD-Tenant der gematik/des Krankenhauses und ist
// bewusst nicht Teil dieses Prototyps. Der Redirect-Flow selbst
// (/authorize → Microsoft-Login → zurück mit #access_token im Hash) ist
// fertig verdrahtet und nutzt denselben tryConsumeUrlHashToken()-Pfad wie
// der Magic-Link-Bonuspfad unten.
function signInWithAzure() {
  const redirectTo = location.origin + location.pathname;
  location.href = `${GOTRUE_URL}/authorize?provider=azure&redirect_to=${encodeURIComponent(redirectTo)}`;
}

// Falls der Nutzer direkt auf den Link in der E-Mail klickt (statt den Code
// manuell einzugeben): GoTrue leitet mit #access_token=...&... im URL-Hash
// weiter (Implicit-Flow). Ohne pro Umgebung konfigurierten redirect_to lässt
// sich das lokal nicht immer exakt treffen — der Code-Eingabe-Weg ist daher
// der primäre, robuste Pfad; das hier ist ein Bonus für den Fall, dass die
// Ports zufällig übereinstimmen. Derselbe Mechanismus verarbeitet auch die
// Rückleitung von signInWithAzure() oben.
function tryConsumeUrlHashToken() {
  if (!location.hash.includes('access_token')) return false;
  const params = new URLSearchParams(location.hash.slice(1));
  const token = params.get('access_token');
  if (!token) return false;
  sessionStorage.setItem('access_token', token);
  sessionStorage.setItem('user_email', decodeJwt(token).email || '');
  history.replaceState(null, '', location.pathname + location.search);
  return true;
}

// ── Gemeinsamer Login-Bildschirm ────────────────────────────────────
function initLoginScreen({ title, hint, onSuccess, ssoAzureEnabled = false }) {
  const screen = document.getElementById('login-screen');
  screen.innerHTML = `
    <div class="login-box">
      <h1>${title}</h1>
      <p class="hint">${hint}</p>

      ${ssoAzureEnabled ? `
      <div id="sso-section">
        <button id="sso-azure-btn" type="button">Mit Microsoft anmelden</button>
      </div>
      <p class="login-small-hint" style="text-align:center;margin:10px 0;">— oder —</p>
      ` : ''}

      <div id="ml-request-section">
        <label for="ml-email">E-Mail</label>
        <input type="email" id="ml-email" autocomplete="username" required>
        <button id="ml-send-btn">Magic-Link senden</button>
        <p class="login-small-hint">Ein Bestätigungscode wird per E-Mail verschickt
          (lokal: <a href="http://localhost:8026" target="_blank" rel="noopener">Mailpit</a>).</p>
      </div>

      <div id="ml-verify-section" style="display:none;">
        <label for="ml-code">Code aus der E-Mail</label>
        <input type="text" id="ml-code" inputmode="numeric" autocomplete="one-time-code" placeholder="6-stelliger Code">
        <button id="ml-verify-btn">Bestätigen</button>
        <button type="button" class="btn-link" id="ml-back-btn">Andere E-Mail-Adresse verwenden</button>
      </div>

      <details id="password-fallback">
        <summary>Alternative: mit Passwort anmelden</summary>
        <label for="pw-email">E-Mail</label>
        <input type="email" id="pw-email" autocomplete="username">
        <label for="pw-password">Passwort</label>
        <input type="password" id="pw-password" autocomplete="current-password">
        <button id="pw-login-btn">Anmelden</button>
      </details>

      <div class="login-error" id="login-error"></div>
    </div>`;

  const errorBox = document.getElementById('login-error');
  const showError = (err) => { errorBox.textContent = err.message; errorBox.style.display = 'block'; };
  const clearError = () => { errorBox.style.display = 'none'; };

  if (ssoAzureEnabled) {
    document.getElementById('sso-azure-btn').addEventListener('click', signInWithAzure);
  }

  async function withButton(btn, busyLabel, fn) {
    clearError();
    const original = btn.textContent;
    btn.disabled = true;
    btn.textContent = busyLabel;
    try {
      await fn();
    } catch (err) {
      showError(err);
    } finally {
      btn.disabled = false;
      btn.textContent = original;
    }
  }

  document.getElementById('ml-send-btn').addEventListener('click', () => {
    const btn = document.getElementById('ml-send-btn');
    withButton(btn, 'Sende …', async () => {
      const email = document.getElementById('ml-email').value;
      if (!email) throw new Error('Bitte E-Mail-Adresse eingeben.');
      await requestMagicLink(email);
      document.getElementById('ml-request-section').style.display = 'none';
      document.getElementById('ml-verify-section').style.display = 'block';
    });
  });

  document.getElementById('ml-verify-btn').addEventListener('click', () => {
    const btn = document.getElementById('ml-verify-btn');
    withButton(btn, 'Prüfe …', async () => {
      const code = document.getElementById('ml-code').value.trim();
      if (!code) throw new Error('Bitte Code eingeben.');
      await verifyMagicLinkCode(code);
      await onSuccess();
    });
  });

  document.getElementById('ml-back-btn').addEventListener('click', () => {
    clearError();
    document.getElementById('ml-verify-section').style.display = 'none';
    document.getElementById('ml-request-section').style.display = 'block';
    document.getElementById('ml-code').value = '';
  });

  document.getElementById('pw-login-btn').addEventListener('click', () => {
    const btn = document.getElementById('pw-login-btn');
    withButton(btn, 'Anmelden …', async () => {
      const email = document.getElementById('pw-email').value;
      const password = document.getElementById('pw-password').value;
      if (!email || !password) throw new Error('Bitte E-Mail und Passwort eingeben.');
      await loginWithPassword(email, password);
      await onSuccess();
    });
  });
}

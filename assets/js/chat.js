/* Chatbot SMK Infokom — widget (tanpa dependensi) */
(() => {
  'use strict';
  const root = document.getElementById('chatbot-root');
  if (!root) return;
  const ep = root.dataset.endpoint, botName = root.dataset.name || 'Asisten', greet = root.dataset.greeting, logo = root.dataset.logo, base = document.body.dataset.base || '';
  const csrf = document.body.dataset.csrf || '';
  const reduce = matchMedia('(prefers-reduced-motion: reduce)').matches;
  const KEY = 'infokom_chat_v1';
  const svg = n => { const s = document.createElementNS('http://www.w3.org/2000/svg', 'svg'); s.setAttribute('class', 'ic'); s.setAttribute('width', 20); s.setAttribute('height', 20); s.setAttribute('aria-hidden', 'true'); const u = document.createElementNS('http://www.w3.org/2000/svg', 'use'); u.setAttribute('href', `${base}/assets/images/icons.svg#${n}`); s.appendChild(u); return s; };
  const el = (t, c, txt) => { const e = document.createElement(t); if (c) e.className = c; if (txt != null) e.textContent = txt; return e; };

  /* launcher */
  const launcher = el('button', 'cb-launcher'); launcher.type = 'button'; launcher.setAttribute('aria-label', 'Buka chat asisten'); launcher.setAttribute('aria-expanded', 'false'); launcher.setAttribute('aria-controls', 'cb-win');
  const lIco = el('span', 'cb-l-ico'); lIco.appendChild(svg('message-circle')); launcher.appendChild(lIco);
  launcher.appendChild(el('span', 'cb-dot'));
  const nudge = el('div', 'cb-nudge', 'Halo! Ada yang bisa kami bantu? 👋'); nudge.hidden = true;

  /* window */
  const win = el('section', 'cb-win'); win.id = 'cb-win'; win.setAttribute('role', 'dialog'); win.setAttribute('aria-label', 'Chat ' + botName); win.hidden = true;
  const head = el('header', 'cb-head');
  const av = el('span', 'cb-av'); if (logo) { const i = document.createElement('img'); i.src = logo; i.alt = ''; av.appendChild(i); } else av.appendChild(svg('sparkles'));
  const ht = el('div', 'cb-ht'); ht.append(el('strong', '', botName), el('small', '', 'Online • menjawab dari data resmi sekolah'));
  const btnReset = el('button', 'cb-ib'); btnReset.type = 'button'; btnReset.title = 'Mulai ulang'; btnReset.setAttribute('aria-label', 'Mulai ulang percakapan'); btnReset.appendChild(svg('refresh'));
  const btnClose = el('button', 'cb-ib'); btnClose.type = 'button'; btnClose.title = 'Tutup'; btnClose.setAttribute('aria-label', 'Tutup chat'); btnClose.appendChild(svg('x'));
  head.append(av, ht, btnReset, btnClose);
  const body = el('div', 'cb-body'); body.setAttribute('aria-live', 'polite'); body.setAttribute('role', 'log');
  const form = el('form', 'cb-form'); form.autocomplete = 'off';
  const input = el('input', 'cb-in'); input.type = 'text'; input.maxLength = 500; input.placeholder = 'Ketik pertanyaan Anda…'; input.setAttribute('aria-label', 'Pertanyaan');
  const send = el('button', 'cb-send'); send.type = 'submit'; send.setAttribute('aria-label', 'Kirim'); send.appendChild(svg('send'));
  form.append(input, send);
  const foot = el('div', 'cb-foot', 'Jawaban otomatis — untuk hal penting hubungi Humas.');
  win.append(head, body, form, foot);
  root.append(nudge, launcher, win);

  /* state */
  let hist = []; try { hist = JSON.parse(sessionStorage.getItem(KEY) || '[]'); } catch { hist = []; }
  const save = () => { try { sessionStorage.setItem(KEY, JSON.stringify(hist.slice(-30))); } catch { /* abaikan */ } };
  const scroll = () => { body.scrollTop = body.scrollHeight; };

  function clearChips() { body.querySelectorAll('.cb-chips').forEach(c => c.remove()); }
  function bubble(role, text, extra) {
    const row = el('div', 'cb-row ' + role); const b = el('div', 'cb-b', text);
    row.appendChild(b);
    if (extra && extra.links && extra.links.length) {
      const ls = el('div', 'cb-links');
      extra.links.slice(0, 4).forEach(l => { const a = el('a', 'cb-link', l.label); a.href = l.url; if (/^https?:\/\//i.test(l.url) && new URL(l.url).origin !== location.origin) { a.target = '_blank'; a.rel = 'noopener noreferrer'; } ls.appendChild(a); });
      row.appendChild(ls);
    }
    body.appendChild(row);
    if (extra && extra.suggestions && extra.suggestions.length) {
      const ch = el('div', 'cb-chips');
      extra.suggestions.slice(0, 6).forEach(s => { const c = el('button', 'cb-chip', s); c.type = 'button'; c.addEventListener('click', () => ask(s)); ch.appendChild(c); });
      body.appendChild(ch);
    }
    scroll();
  }
  function typing() { const r = el('div', 'cb-row bot cb-typing'); const b = el('div', 'cb-b'); b.append(el('i'), el('i'), el('i')); r.appendChild(b); body.appendChild(r); scroll(); return r; }

  function renderAll() {
    body.textContent = '';
    if (!hist.length) { bubble('bot', greet, { suggestions: ['Info PPDB', 'Jurusan apa saja?', 'Biaya & persyaratan', 'Alamat & kontak', 'Fasilitas sekolah', 'Lowongan kerja (BKK)'] }); return; }
    hist.forEach((m, i) => bubble(m.role === 'assistant' ? 'bot' : 'user', m.text, i === hist.length - 1 && m.role === 'assistant' ? { links: m.links, suggestions: m.suggestions } : null));
  }

  let busy = false;
  async function ask(text) {
    text = (text || '').trim(); if (!text || busy) return;
    busy = true; clearChips(); input.value = '';
    bubble('user', text);
    const history = hist.slice(-8).map(m => ({ role: m.role, text: m.text }));
    hist.push({ role: 'user', text }); save();
    const t = typing(); await new Promise(r => setTimeout(r, reduce ? 0 : 450));
    try {
      const r = await fetch(ep, { method: 'POST', headers: { 'Content-Type': 'application/json', Accept: 'application/json', 'X-CSRF-Token': csrf, 'X-Requested-With': 'XMLHttpRequest' }, body: JSON.stringify({ message: text, history }) });
      const d = await r.json().catch(() => null);
      t.remove();
      if (r.ok && d && d.ok) { hist.push({ role: 'assistant', text: d.reply, links: d.links, suggestions: d.suggestions }); save(); bubble('bot', d.reply, d); }
      else bubble('bot', (d && d.message) || 'Maaf, terjadi gangguan. Silakan coba lagi sebentar.', { suggestions: ['Info PPDB', 'Alamat & kontak'] });
    } catch { t.remove(); bubble('bot', 'Koneksi bermasalah. Periksa internet Anda lalu coba lagi.'); }
    busy = false; input.focus();
  }

  function open() { win.hidden = false; requestAnimationFrame(() => win.classList.add('open')); launcher.setAttribute('aria-expanded', 'true'); launcher.classList.add('is-open'); lIco.replaceChildren(svg('x')); nudge.hidden = true; renderAll(); setTimeout(() => input.focus(), 150); sessionStorage.setItem(KEY + '_seen', '1'); }
  function close() { win.classList.remove('open'); launcher.setAttribute('aria-expanded', 'false'); launcher.classList.remove('is-open'); lIco.replaceChildren(svg('message-circle')); setTimeout(() => { win.hidden = true; }, reduce ? 0 : 220); launcher.focus(); }
  launcher.addEventListener('click', () => (win.hidden ? open() : close()));
  btnClose.addEventListener('click', close);
  btnReset.addEventListener('click', () => { hist = []; save(); renderAll(); input.focus(); });
  form.addEventListener('submit', e => { e.preventDefault(); ask(input.value); });
  document.addEventListener('keydown', e => { if (e.key === 'Escape' && !win.hidden) close(); });
  window.openChatbot = open;

  /* sapaan singkat sekali per sesi */
  if (!sessionStorage.getItem(KEY + '_seen')) setTimeout(() => { if (win.hidden) { nudge.hidden = false; setTimeout(() => { nudge.hidden = true; }, 7000); } }, 6000);
})();

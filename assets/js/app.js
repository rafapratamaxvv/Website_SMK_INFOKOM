/* SMK Infokom Kota Bogor — app.js (tanpa dependensi) */
(() => {
  'use strict';
  const $ = (s, c = document) => c.querySelector(s);
  const $$ = (s, c = document) => Array.from(c.querySelectorAll(s));
  const base = document.body.dataset.base || '';
  const csrf = document.body.dataset.csrf || '';
  const reduce = matchMedia('(prefers-reduced-motion: reduce)').matches;

  /* Loader + page transition */
  const hideLoader = () => document.body.classList.remove('is-loading');
  addEventListener('load', () => setTimeout(hideLoader, reduce ? 0 : 350));
  setTimeout(hideLoader, 2500);
  addEventListener('pageshow', e => { if (e.persisted) document.body.classList.remove('page-out'); });
  document.addEventListener('click', e => {
    const a = e.target.closest('a[href]');
    if (!a || reduce || e.defaultPrevented || e.metaKey || e.ctrlKey || e.shiftKey || e.button) return;
    if (a.target === '_blank' || a.hasAttribute('download') || a.origin !== location.origin) return;
    const u = new URL(a.href);
    if (u.pathname === location.pathname && u.search === location.search) return;
    if (/\.(pdf|xml|csv|sql)$/i.test(u.pathname) || u.pathname.includes('/bukti/')) return;
    e.preventDefault();
    document.body.classList.add('page-out');
    setTimeout(() => { location.href = a.href; }, 230);
  });

  /* Toast */
  window.toast = (msg, type = '') => {
    const wrap = $('#toasts'); if (!wrap) return;
    const t = document.createElement('div');
    t.className = 'toast ' + type; t.textContent = msg; wrap.appendChild(t);
    setTimeout(() => { t.classList.add('out'); setTimeout(() => t.remove(), 320); }, 4200);
  };

  /* Header */
  const header = $('#siteHeader');
  const onScroll = () => {
    header && header.classList.toggle('is-stuck', scrollY > 8);
    const tt = $('#toTop'); tt && tt.classList.toggle('show', scrollY > 600);
    if (!reduce) $$('[data-parallax]').forEach(el => {
      const r = el.parentElement.getBoundingClientRect();
      if (r.bottom < 0 || r.top > innerHeight) return;
      el.style.transform = `translate3d(0,${(r.top * -0.18).toFixed(1)}px,0)`;
    });
  };
  addEventListener('scroll', onScroll, { passive: true }); onScroll();
  $('#toTop')?.addEventListener('click', () => scrollTo({ top: 0, behavior: reduce ? 'auto' : 'smooth' }));

  /* Desktop dropdown */
  $$('.has-sub > button').forEach(b => b.addEventListener('click', e => {
    e.stopPropagation();
    const li = b.parentElement, open = li.classList.toggle('open');
    b.setAttribute('aria-expanded', open);
    $$('.has-sub.open').forEach(o => { if (o !== li) { o.classList.remove('open'); o.firstElementChild.setAttribute('aria-expanded', 'false'); } });
  }));
  document.addEventListener('click', () => $$('.has-sub.open').forEach(o => { o.classList.remove('open'); o.firstElementChild.setAttribute('aria-expanded', 'false'); }));

  /* Mobile menu */
  const menuBtn = $('#menuBtn'), mnav = $('#mobileNav');
  menuBtn?.addEventListener('click', () => {
    const open = menuBtn.getAttribute('aria-expanded') !== 'true';
    menuBtn.setAttribute('aria-expanded', open); mnav.hidden = !open;
  });
  $$('.m-acc > button').forEach(b => b.addEventListener('click', () => {
    const li = b.parentElement, open = li.classList.toggle('open'); b.setAttribute('aria-expanded', open);
  }));

  /* Search */
  const sm = $('#searchModal'), si = $('#searchInput'), sr = $('#searchResults');
  const openSearch = () => { sm.hidden = false; setTimeout(() => si.focus(), 30); };
  const closeSearch = () => { sm.hidden = true; };
  $('#searchOpen')?.addEventListener('click', openSearch);
  $('#searchClose')?.addEventListener('click', closeSearch);
  sm?.addEventListener('click', e => { if (e.target === sm) closeSearch(); });
  let timer, ctl;
  si?.addEventListener('input', () => {
    clearTimeout(timer);
    const q = si.value.trim();
    if (q.length < 2) { sr.innerHTML = ''; return; }
    timer = setTimeout(async () => {
      ctl?.abort(); ctl = new AbortController();
      sr.innerHTML = '<div class="sr-empty skeleton" style="height:52px;margin:.6rem"></div>';
      try {
        const r = await fetch(`${base}/api/search?q=${encodeURIComponent(q)}`, { headers: { Accept: 'application/json' }, signal: ctl.signal });
        const d = await r.json();
        sr.textContent = '';
        if (!d.results.length) { const e = document.createElement('div'); e.className = 'sr-empty'; e.textContent = 'Tidak ada hasil untuk “' + q + '”.'; sr.appendChild(e); return; }
        d.results.forEach(x => {
          const a = document.createElement('a'); a.className = 'sr-item'; a.href = x.url;
          const t = document.createElement('div'); t.className = 'sr-type'; t.textContent = x.type;
          const h = document.createElement('strong'); h.textContent = x.title;
          const p = document.createElement('div'); p.className = 'muted'; p.textContent = x.desc;
          a.append(t, h, p); sr.appendChild(a);
        });
      } catch (err) { if (err.name !== 'AbortError') sr.innerHTML = '<div class="sr-empty">Pencarian gagal. Coba lagi.</div>'; }
    }, 250);
  });

  /* Reveal (IntersectionObserver) */
  $$('.reveal-text').forEach(el => {
    if (el.dataset.split) return; el.dataset.split = 1;
    const txt = el.textContent.trim().split(/\s+/);
    el.textContent = '';
    txt.forEach((w, i) => { const s = document.createElement('span'); s.className = 'w'; s.style.setProperty('--i', i); s.textContent = w; el.append(s, ' '); });
  });
  const io = new IntersectionObserver(es => es.forEach(e => {
    if (!e.isIntersecting) return;
    e.target.classList.add('in'); io.unobserve(e.target);
    if (e.target.dataset.count !== undefined) countUp(e.target);
  }), { threshold: .12, rootMargin: '0px 0px -6% 0px' });
  $$('.reveal,.reveal-text,.img-reveal,[data-count]').forEach((el, i) => { if (el.classList.contains('reveal') && !el.style.getPropertyValue('--d')) el.style.setProperty('--d', ((i % 4) * .08) + 's'); io.observe(el); });

  function countUp(el) {
    const end = parseInt(el.dataset.count, 10) || 0, suf = el.dataset.suffix || '';
    if (reduce || end === 0) { el.textContent = end.toLocaleString('id-ID') + suf; return; }
    const t0 = performance.now(), dur = 1400;
    const step = t => { const p = Math.min(1, (t - t0) / dur), v = Math.round(end * (1 - Math.pow(1 - p, 3))); el.textContent = v.toLocaleString('id-ID') + suf; if (p < 1) requestAnimationFrame(step); };
    requestAnimationFrame(step);
  }

  /* Lazy images (fade-in) */
  $$('img[loading=lazy]').forEach(img => {
    img.classList.add('lazy');
    const done = () => img.classList.add('loaded');
    img.complete ? done() : (img.addEventListener('load', done), img.addEventListener('error', done));
  });

  /* Lightbox */
  const lb = $('#lightbox');
  if (lb) {
    let group = [], idx = 0;
    const show = i => {
      idx = (i + group.length) % group.length;
      const f = group[idx]; $('img', lb).src = f.dataset.full || $('img', f).src; $('img', lb).alt = $('img', f).alt;
      $('figcaption', lb).textContent = f.dataset.caption || '';
    };
    document.addEventListener('click', e => {
      const f = e.target.closest('[data-lightbox]'); if (!f) return;
      e.preventDefault();
      group = $$(`[data-lightbox="${f.dataset.lightbox}"]`); idx = group.indexOf(f);
      lb.hidden = false; show(idx); $('.lb-close', lb).focus();
    });
    $('.lb-close', lb).addEventListener('click', () => lb.hidden = true);
    $('.lb-prev', lb).addEventListener('click', () => show(idx - 1));
    $('.lb-next', lb).addEventListener('click', () => show(idx + 1));
    lb.addEventListener('click', e => { if (e.target === lb) lb.hidden = true; });
    document.addEventListener('keydown', e => {
      if (lb.hidden) return;
      if (e.key === 'Escape') lb.hidden = true; if (e.key === 'ArrowLeft') show(idx - 1); if (e.key === 'ArrowRight') show(idx + 1);
    });
  }

  /* Modal (detail guru/staff) */
  $$('[data-modal]').forEach(card => card.addEventListener('click', () => {
    const m = document.getElementById(card.dataset.modal); if (m) { m.hidden = false; $('.modal-close', m)?.focus(); }
  }));
  $$('.modal').forEach(m => {
    m.addEventListener('click', e => { if (e.target === m || e.target.closest('.modal-close')) m.hidden = true; });
  });
  document.addEventListener('keydown', e => {
    if (e.key !== 'Escape') return;
    $$('.modal:not([hidden])').forEach(m => m.hidden = true);
    if (sm && !sm.hidden) closeSearch();
  });

  /* YouTube click-to-play (youtube-nocookie) */
  $$('.vid button[data-yt]').forEach(b => b.addEventListener('click', () => {
    const f = document.createElement('iframe');
    f.src = `https://www.youtube-nocookie.com/embed/${encodeURIComponent(b.dataset.yt)}?autoplay=1&rel=0`;
    f.title = b.getAttribute('aria-label') || 'Video'; f.allow = 'autoplay; encrypted-media; picture-in-picture'; f.allowFullscreen = true; f.loading = 'lazy';
    b.replaceWith(f);
  }));

  /* Video YouTube / TikTok / Instagram: muat iframe hanya saat diklik (hemat data & privasi) */
  const EMBED_OK = /^https:\/\/(www\.youtube-nocookie\.com\/embed\/[\w-]{11}|www\.tiktok\.com\/embed\/v2\/\d+|www\.instagram\.com\/(p|reel|tv)\/[\w-]+\/embed\/?)/;
  $$('button[data-embed]').forEach(b => b.addEventListener('click', () => {
    const src = b.dataset.embed; if (!EMBED_OK.test(src)) return;
    const f = document.createElement('iframe');
    f.src = src; f.title = b.dataset.title || 'Video'; f.allow = 'autoplay; encrypted-media; picture-in-picture; fullscreen'; f.allowFullscreen = true; f.loading = 'lazy';
    b.replaceWith(f);
  }));

  /* Filter tabs (client side) */
  $$('[data-filter-group]').forEach(group => {
    const chips = $$('[data-filter]', group), items = $$(group.dataset.filterGroup);
    chips.forEach(c => c.addEventListener('click', () => {
      chips.forEach(x => x.classList.toggle('is-active', x === c));
      items.forEach(i => { const show = c.dataset.filter === '*' || i.dataset.cat === c.dataset.filter; i.hidden = !show; });
    }));
  });

  /* AJAX forms */
  $$('form[data-ajax]').forEach(form => {
    const msg = document.createElement('div'); msg.className = 'js-ajax-msg'; msg.setAttribute('aria-live', 'polite'); form.append(msg);
    form.addEventListener('submit', async e => {
      if (!form.checkValidity()) { form.reportValidity(); e.preventDefault(); return; }
      e.preventDefault();
      $$('.field-error', form).forEach(x => x.remove()); $$('.has-error', form).forEach(x => x.classList.remove('has-error'));
      const btn = $('[type=submit]', form), label = btn.innerHTML; btn.disabled = true; btn.textContent = 'Mengirim…';
      try {
        const r = await fetch(form.action, { method: 'POST', body: new FormData(form), headers: { Accept: 'application/json', 'X-Requested-With': 'XMLHttpRequest', 'X-CSRF-Token': csrf } });
        const d = await r.json().catch(() => ({ ok: false, message: 'Respons server tidak valid.' }));
        if (d.ok) {
          if (d.redirect) { location.href = d.redirect; return; }
          form.reset(); msg.innerHTML = ''; toast(d.message || 'Berhasil.');
        } else {
          if (d.errors) Object.entries(d.errors).forEach(([k, v]) => {
            const el = form.elements[k] || form.elements[k + '[]']; const wrap = el && (el.closest ? el.closest('.field') : null);
            if (wrap) { wrap.classList.add('has-error'); const s = document.createElement('small'); s.className = 'field-error'; s.textContent = v; wrap.append(s); }
          });
          toast(d.message || 'Periksa kembali isian Anda.', 'err');
          $('.has-error', form)?.scrollIntoView({ behavior: reduce ? 'auto' : 'smooth', block: 'center' });
        }
      } catch { toast('Koneksi bermasalah. Coba lagi.', 'err'); }
      btn.disabled = false; btn.innerHTML = label;
    });
  });

  /* Client-side file size guard */
  $$('input[type=file][data-max]').forEach(inp => inp.addEventListener('change', () => {
    const max = parseInt(inp.dataset.max, 10);
    for (const f of inp.files) if (f.size > max) { toast(`File "${f.name}" melebihi ${(max / 1048576).toFixed(0)} MB.`, 'err'); inp.value = ''; break; }
  }));

  /* Unduh otomatis (halaman sukses PPDB) */
  const ad = $('[data-autodownload]');
  if (ad) setTimeout(() => { const a = document.createElement('a'); a.href = ad.dataset.autodownload; a.download = ''; a.hidden = true; document.body.appendChild(a); a.click(); a.remove(); }, 600);

  /* Pintasan keyboard: Ctrl+Shift+L (atau Alt+Shift+A) → halaman admin */
  document.addEventListener('keydown', e => {
    const hit = ((e.ctrlKey || e.metaKey) && e.shiftKey && e.code === 'KeyL') || (e.altKey && e.shiftKey && e.code === 'KeyA');
    if (!hit) return;
    e.preventDefault();
    if (window.toast) toast('Membuka halaman admin…');
    location.href = base + '/admin';
  });

  /* Efek hover gambar: tilt 3D, kilau cahaya, paralaks, dan kursor interaktif */
  (() => {
    if (reduce || !matchMedia('(hover: hover) and (pointer: fine)').matches) return;
    const HOSTS = [
      ['.principal-frame', '.pf-photo', 9],
      ['.card:not(.portrait):not(.video-card)', '.card-img', 0],
      ['.portrait', '.ph', 0],
      ['.img-reveal:not(.is-portrait)', null, 6],
      ['.promo-img', null, 6],
      ['.article-cover', null, 5],
      ['.masonry figure', null, 5],
    ];
    const bind = (host, targetSel, max) => {
      if (host.dataset.fx) return;
      const target = targetSel ? host.querySelector(targetSel) : host;
      if (targetSel && !target) { host.dataset.fx = 'x'; return; }
      host.dataset.fx = '1';
      const glare = document.createElement('span'); glare.className = 'fx-glare'; glare.setAttribute('aria-hidden', 'true'); target.appendChild(glare);
      let raf = 0, ev = null;
      const set = (k, v) => host.style.setProperty(k, v);
      const apply = () => {
        raf = 0; const r = host.getBoundingClientRect();
        const x = (ev.clientX - r.left) / r.width, y = (ev.clientY - r.top) / r.height, nx = x * 2 - 1, ny = y * 2 - 1;
        set('--px', nx.toFixed(3)); set('--py', ny.toFixed(3)); set('--mx', (x * 100).toFixed(1) + '%'); set('--my', (y * 100).toFixed(1) + '%');
        set('--rx', (-ny * max).toFixed(2) + 'deg'); set('--ry', (nx * max * 1.2).toFixed(2) + 'deg');
      };
      host.addEventListener('pointerenter', () => host.classList.add('fx-on'));
      host.addEventListener('pointermove', e => { ev = e; if (!raf) raf = requestAnimationFrame(apply); });
      host.addEventListener('pointerleave', () => { host.classList.remove('fx-on'); set('--px', '0'); set('--py', '0'); set('--rx', '0deg'); set('--ry', '0deg'); });
    };
    HOSTS.forEach(([hs, ts, max]) => $$(hs).forEach(h => bind(h, ts, max)));

    /* kursor bubble yang mengikuti mouse di atas gambar */
    const cur = document.createElement('div'); cur.className = 'cursor-bubble'; cur.setAttribute('aria-hidden', 'true');
    const lab = document.createElement('span'); cur.appendChild(lab); document.body.appendChild(cur);
    let tx = 0, ty = 0, cx = 0, cy = 0, run = false;
    const SEL = '[data-lightbox], .card-img, .principal-frame .pf-photo, .img-reveal, .promo-img, .portrait .ph, .article-cover';
    const loop = () => {
      cx += (tx - cx) * 0.2; cy += (ty - cy) * 0.2;
      cur.style.transform = `translate3d(${cx.toFixed(1)}px,${cy.toFixed(1)}px,0)`;
      if (Math.abs(tx - cx) > 0.3 || Math.abs(ty - cy) > 0.3) requestAnimationFrame(loop); else run = false;
    };
    document.addEventListener('pointermove', e => {
      tx = e.clientX; ty = e.clientY;
      const t = e.target.closest ? e.target.closest(SEL) : null;
      if (t) {
        const txt = t.closest('[data-lightbox]') ? 'Perbesar' : (t.closest('.card') && t.closest('.card').querySelector('a.card-link') ? 'Buka' : '');
        lab.textContent = txt; cur.classList.add('show'); cur.classList.toggle('has-label', !!txt);
      } else cur.classList.remove('show');
      if (!run) { run = true; requestAnimationFrame(loop); }
    }, { passive: true });
    document.addEventListener('mouseleave', () => cur.classList.remove('show'));
  })();

  /* Confirm */
  document.addEventListener('submit', e => { const c = e.target.dataset?.confirm; if (c && !confirm(c)) e.preventDefault(); });
})();

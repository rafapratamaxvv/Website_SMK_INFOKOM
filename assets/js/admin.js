(() => {
  'use strict';
  document.getElementById('sideToggle')?.addEventListener('click', () => document.body.classList.toggle('side-open'));
  document.addEventListener('click', e => { if (document.body.classList.contains('side-open') && !e.target.closest('.sidebar') && !e.target.closest('#sideToggle')) document.body.classList.remove('side-open'); });
  document.addEventListener('keydown', e => {
    if ((e.ctrlKey || e.metaKey) && e.shiftKey && e.code === 'KeyL') { e.preventDefault(); location.href = (document.body.dataset.base || '') + '/'; }
  });
  document.addEventListener('submit', e => { const c = e.target.dataset?.confirm; if (c && !confirm(c)) e.preventDefault(); });
  document.querySelectorAll('input[type=file][data-preview]').forEach(inp => inp.addEventListener('change', () => {
    const t = document.getElementById(inp.dataset.preview); const f = inp.files[0];
    if (t && f && f.type.startsWith('image/')) { t.src = URL.createObjectURL(f); t.hidden = false; }
  }));
  /* Kolom bersyarat (mis. Video URL hanya tampil bila jenis media = Video URL) */
  document.querySelectorAll('[data-only-if]').forEach(box => {
    const [name, val] = box.dataset.onlyIf.split('=');
    const form = box.closest('form'), ctl = form && form.elements[name];
    if (!ctl) return;
    const sync = () => { box.hidden = ctl.value !== val; };
    ctl.addEventListener('change', sync); sync();
  });
  document.querySelectorAll('select[data-autosubmit]').forEach(s => s.addEventListener('change', () => s.form.submit()));
})();

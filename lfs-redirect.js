(function () {
  var LFS_EXTS = ["mp4","webm","odp","zip","pdf","pptx","key","swf","tgz","rar","msi","ppt","gz","bz2","7z","doc","odt","exe","00","01","02"];
  var SELECTORS = [
    ["a","href"], ["img","src"], ["video","src"], ["audio","src"],
    ["source","src"], ["link","href"], ["iframe","src"]
  ];

  function getExtension(pathname) {
    var match = String(pathname || "").toLowerCase().match(/\.([a-z0-9]+)$/);
    return match ? match[1] : "";
  }

  function isGithubHost(hostname) {
    return /(^|\.)github\.com$/.test(hostname) || /(^|\.)githubusercontent\.com$/.test(hostname);
  }

  function buildGithubUrl(u) {
    var path = u.pathname.replace(/^\//, "") + (u.search || "") + (u.hash || "");
    var ext = getExtension(u.pathname);
    if (ext === "pdf") {
      return "https://media.githubusercontent.com/media/ocftw/openfoundry.org/gh-pages/" + path;
    }
    return "https://github.com/ocftw/openfoundry.org/blob/gh-pages/" + path;
  }

  function rewriteElement(el, tag, attr) {
    var val = el.getAttribute(attr);
    if (!val) return;

    var u;
    try {
      u = new URL(val, location.href);
    } catch (e) {
      return;
    }

    if (u.origin !== location.origin) return;

    var ext = getExtension(u.pathname);
    if (LFS_EXTS.indexOf(ext) === -1) return;

    if (isGithubHost(u.hostname)) return;

    var gh = buildGithubUrl(u);
    el.setAttribute(attr, gh);

    if (tag === "a" && ext !== "pdf") {
      el.setAttribute("target", "_blank");
      el.setAttribute("rel", "noopener");
    }
  }

  function run() {
    for (var i = 0; i < SELECTORS.length; i++) {
      var pair = SELECTORS[i];
      var tag = pair[0];
      var attr = pair[1];
      var nodes = document.querySelectorAll(tag + "[" + attr + "]");
      for (var j = 0; j < nodes.length; j++) {
        rewriteElement(nodes[j], tag, attr);
      }
    }
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", run);
  } else {
    run();
  }
})();

// ThundR HAWK STATUS-bar hook (additive, v2.1.9). Reads RCONTRALROOM/THUNDR-FLOAT/hawk-status.json.
// Adds window.thundrHawkStatus() + window.thundrHawkBar(); removes nothing. Shows text only on WARN/ALERT.
(function(){
  var SRC = (window.THUNDR_HAWK_URL || "hawk-status.json");
  window.thundrHawkStatus = function(){ return fetch(SRC + "?t=" + Date.now(), {cache:"no-store"}).then(function(r){return r.json();}); };
  window.thundrHawkBar = function(){
    return window.thundrHawkStatus().then(function(s){
      var bar = document.getElementById("thundr-bar"); var lab = document.querySelector("[data-thundr-label]") || bar;
      var warn = (s.watched_kb||0) > 5*1048576 || (s.free_kb||1e12) < 15*1048576;
      document.documentElement.setAttribute("data-hawk", s.bar || "");
      if (lab) { lab.title = s.bar || ""; if (warn) lab.setAttribute("data-hawk-warn", s.bar); else lab.removeAttribute("data-hawk-warn"); }
      return s;
    }).catch(function(){ return null; });
  };
  window.thundrHawkBar(); setInterval(window.thundrHawkBar, 300000);
})();

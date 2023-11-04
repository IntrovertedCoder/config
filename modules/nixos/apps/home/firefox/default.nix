{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.firefox;
in
{
  options.plusultra.apps.home.firefox = with types; {
    enable = mkBoolOpt false "Whether or not to enable firefox.";
  };

  config = mkIf cfg.enable {
    plusultra.home.extraOptions = {
      programs = {
        firefox = { # {{{
          enable = true;
          profiles = { # {{{
            email1 = { # {{{
              extensions = with pkgs.nur.repos.rycee.firefox-addons; [
                ublock-origin
                bitwarden
                darkreader
                auto-tab-discard
                enhancer-for-youtube
                onetab
                firefox-color
                decentraleyes
                privacy-badger
                markdownload
                videospeed
              ];
              id = 0;
              isDefault = true;
              name = "email1";
              settings = { # {{{
                "browser.gesture.swipe.left" =                                    "\"\"";
                "browser.gesture.swipe.right" =                                   "\"\"";
                "browser.uiCustomization.state" = "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[\"jid1-mnnxcxisbpnsxq_jetpack-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"_c2c003ee-bd69-42a2-b0e9-6f34222cb046_-browser-action\",\"firefoxcolor_mozilla_com-browser-action\",\"jid1-bofifl9vbdl2zq_jetpack-browser-action\",\"_7be2ba16-0f1e-4d93-9ebc-5164397477a9_-browser-action\"],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"urlbar-container\",\"downloads-button\",\"unified-extensions-button\",\"_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action\",\"enhancerforyoutube_maximerf_addons_mozilla_org-browser-action\",\"extension_one-tab_com-browser-action\",\"addon_darkreader_org-browser-action\",\"_1c5e4c6f-5530-49a3-b216-31ce7d744db0_-browser-action\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"firefox-view-button\",\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"PersonalToolbar\":[\"import-button\",\"personal-bookmarks\"]},\"seen\":[\"save-to-pocket-button\",\"developer-button\",\"_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"_c2c003ee-bd69-42a2-b0e9-6f34222cb046_-browser-action\",\"addon_darkreader_org-browser-action\",\"enhancerforyoutube_maximerf_addons_mozilla_org-browser-action\",\"extension_one-tab_com-browser-action\",\"firefoxcolor_mozilla_com-browser-action\",\"jid1-bofifl9vbdl2zq_jetpack-browser-action\",\"jid1-mnnxcxisbpnsxq_jetpack-browser-action\",\"_1c5e4c6f-5530-49a3-b216-31ce7d744db0_-browser-action\",\"_7be2ba16-0f1e-4d93-9ebc-5164397477a9_-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"PersonalToolbar\",\"unified-extensions-area\",\"toolbar-menubar\",\"TabsToolbar\"],\"currentVersion\":19,\"newElementCount\":7}";
                # Enable restore previous session
                "browser.startup.page" = "3";
                # https://brainfucksec.github.io/firefox-hardening-guide
                  # Startup Settings
                    # "browser.startup.page" = "1"; # I want this changed specifically
                    "browser.aboutConfig.showWarning" =                            "false";
                    "browser.newtabpage.enabled" =                                 "false";
                    "browser.newtab.preload" =                                     "false";
                    "browser.newtabpage.activity-stream.feeds.telemetry" =         "false";
                    "browser.newtabpage.activity-stream.telemetry" =               "false";
                    "browser.newtabpage.activity-stream.feeds.snippets" =          "false";
                    "browser.newtabpage.activity-stream.section.topstories" =      "false";
                    "browser.newtabpage.activity-stream.section.highlights.includePocket" = "false";
                    "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = "false";
                    "browser.newtabpage.activity-stream.showSponsored" =           "false";
                    "browser.newtabpage.activity-stream.showSponsoredTopSites" =   "false";
                    "browser.newtabpage.activity-stream.default.sites" =           "\"\"";
                  # Geolocation
                    # Not doing this one because no mozilla api key
                    # "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
                    "geo.provider.use_gpsd" =                                      "false";
                    "geo.provider.use_geoclue" =                                    "false";
                  # Language/Locale
                    "intl.accept_languages" =                                      "en-US, en";
                    "javascript.use_us_english_locale" =                           "true";
                  # Auto-updates
                    "app.update.auto" =                                            "false";
                    "extensions.getAddons.showPane" =                              "false";
                    "extensions.htmlaboutaddons.recommendations.enabled" =         "false";
                    "browser.discovery.enabled" =                                  "false";
                  # Telemetry
                    "datareporting.policy.dataSubmissionEnabled" =                 "false";
                    "datareporting.healthreport.uploadEnabled" =                   "false";
                    "toolkit.telemetry.enabled" =                                  "false";
                    "toolkit.telemetry.unified" =                                  "false";
                    "toolkit.telemetry.server" =                                   "data:,";
                    "toolkit.telemetry.archive.enabled" =                          "false";
                    "toolkit.telemetry.newProfilePing.enabled" =                   "false";
                    "toolkit.telemetry.shutdownPingSender.enabled" =               "false";
                    "toolkit.telemetry.updatePing.enabled" =                       "false";
                    "toolkit.telemetry.bhrPing.enabled" =                          "false";
                    "toolkit.telemetry.firstShutdownPing.enabled" =                "false";
                    "toolkit.telemetry.coverage.opt-out" =                         "true";
                    "toolkit.coverage.opt-out" =                                   "true";
                    "toolkit.coverage.endpoint.base" =                             "\"\"";
                    "browser.ping-centre.telemetry" =                              "false";
                    "beacon.enabled" =                                             "false";
                  # Studies
                    "app.shield.optoutstudies.enabled" =                           "false";
                    "app.normandy.enabled" =                                       "false";
                    "app.normandy.api_url" =                                       "\"\"";
                  # Crash Reports
                    "breakpad.reportURL" =                                         "\"\"";
                    "browser.tabs.crashReporting.sendReport" =                     "false";
                  # Captive Portal Detection / Network Checks
                    # I would disable these but I use these sometimes
                  # Safe Browsing
                    "browser.safebrowsing.malware.enabled" =                       "false";
                    "browser.safebrowsing.phishing.enabled" =                      "false";
                    "browser.safebrowsing.blockedURIs.enabled" =                   "false";
                    "browser.safebrowsing.provider.google4.gethashURL" =           "\"\"";
                    "browser.safebrowsing.provider.google4.updateURL" =            "\"\"";
                    "browser.safebrowsing.provider.google.gethashURL" =            "\"\"";
                    "browser.safebrowsing.provider.google.updateURL" =             "\"\"";
                    "browser.safebrowsing.provider.google4.dataSharingURL" =       "\"\"";
                    # I might disable these three
                    "browser.safebrowsing.downloads.enabled" =                     "false";
                    "browser.safebrowsing.downloads.remote.enabled" =              "false";
                    "browser.safebrowsing.downloads.remote.url" =                  "\"\"";
                    "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = "false";
                    "browser.safebrowsing.downloads.remote.block_uncommon" =       "false";
                    "browser.safebrowsing.allowOverride" =                         "false";
                  # Network
                    "network.prefetch-next" =                                      "false";
                    "network.dns.disablePrefetch" =                                "true";
                    "network.predictor.enabled" =                                  "false";
                    "network.http.speculative-parallel-limit" =                    "0";
                    "browser.places.speculativeConnect.enabled" =                  "false";
                    "network.dns.disableIPv6" =                                    "true";
                    "network.gio.supported-protocols" =                            "\"\"";
                    "network.file.disable_unc_paths" =                             "true";
                    "permissions.manager.defaultsUrl" =                            "\"\"";
                    "network.IDN_show_punycode" =                                  "true";
                  # Search Bar
                    "browser.search.suggest.enabled" =                             "false";
                    "browser.urlbar.suggest.searches" =                            "false";
                    "browser.fixup.alternate.enabled" =                            "false";
                    "browser.urlbar.trimURLs" =                                    "false";
                    "browser.urlbar.speculativeConnect.enabled" =                  "false";
                    "browser.formfill.enable" =                                    "false";
                    "extensions.formautofill.addresses.enabled" =                  "false";
                    "extensions.formautofill.available" =                          "off";
                    "extensions.formautofill.creditCards.available" =              "false";
                    "extensions.formautofill.creditCards.enabled" =                "false";
                    "extensions.formautofill.heuristics.enabled" =                 "false";
                    "browser.urlbar.quicksuggest.scenario" =                       "history";
                    "browser.urlbar.quicksuggest.enabled" =                        "false";
                    "browser.urlbar.suggest.quicksuggest.nonsponsored" =           "false";
                    "browser.urlbar.suggest.quicksuggest.sponsored" =              "false";
                  # Passwords
                    "signon.rememberSignons" =                                     "false";
                    "signon.autofillForms" =                                       "false";
                    "signon.formlessCapture.enabled" =                             "false";
                    # Might change this to 2 which is default
                    "network.auth.subresource-http-auth-allow" =                   "1";
                  # Disk Cache / Memory
                    # I might add these but I think I use most of them
                  # HTTPS / SSL/TLS / OSCP / CERTS
                    "dom.security.https_only_mode" =                               "true";
                    "dom.security.https_only_mode_send_http_background_request" =  "false";
                    "browser.xul.error_pages.expert_bad_cert" =                    "true";
                    "security.tls.enable_0rtt_data" =                              "false";
                    "security.OCSP.require" =                                      "true";
                    # Might need to change these to another value for Rubidium
                    "security.pki.sha1_enforcement_level" =                        "1";
                    "security.cert_pinning.enforcement_level" =                    "2";
                    "security.remote_settings.crlite_filters.enabled" =            "true";
                    "security.pki.crlite_mode" =                                   "2";
                  # Headers / Referers
                    "network.http.referer.XOriginPolicy" =                         "2";
                    "network.http.referer.XOriginTrimmingPolicy" =                 "2";
                  # Audio/Video WebRTC, WebGL, DRM
                    # Might need to modify these for netflix to work
                    "media.peerconnection.enabled" =                               "false";
                    "media.peerconnection.ice.proxy_only_if_behind_proxy" =        "true";
                    "media.peerconnection.ice.default_address_only" =              "true";
                    "media.peerconnection.ice.no_host" =                           "true";
                    "webgl.disabled" =                                             "true";
                    "media.autoplay.default" =                                     "5";
                    # DRM
                    "media.eme.enabled" =                                          "true";
                  # Downloads
                    "browser.download.useDownloadDir" =                            "false";
                    "browser.download.manager.addToRecentDocs" =                   "false";
                  # Cookies
                    "browser.contentblocking.category" =                           "strict";
                    "privacy.partition.serviceWorkers" =                           "true";
                    "privacy.partition.always_partition_third_party_non_cookie_storage" = "true";
                    "privacy.partition.always_partition_third_party_non_cookie_storage.exempt_sessionstorage" = "true";
                  # UI Features
                    "dom.disable_open_during_load" =                               "true";
                    "dom.popup_allowed_events" =                                   "click dblclick mousedown pointerdown";
                    "extensions.pocket.enabled" =                                  "false";
                    "extensions.screenshots.disabled" =                            "true";
                    "pdfjs.enableScripting" =                                      "false";
                    "privacy.userContext.enabled" =                                "true";
                    "privacy.userContext.ui.enabled" =                             "true";
                  # Extensions
                    "extensions.enabledScopes" =                                   "5";
                    "extensions.webextensions.restrictedDomains" =                   "\"\"";
                    "extensions.postDownloadThirdPartyPrompt" =                    "false";
                  # Shutdown Settings
                    # I'm not going to touch these since I plan on using this profile as my main
                  # Fingerprinting (RFP)
                    "privacy.resistFingerprinting" =                               "true";
                    "privacy.window.maxInnerWidth" =                               "1600";
                    "privacy.window.maxInnerHeight" =                              "900";
                    "privacy.resistFingerprinting.block_mozAddonManager" =         "true";
                    "browser.display.use_system_colors" =                          "false";
              }; # }}}
              search = {
                force = true;
                default = "SearXNG_Local";
                engines = {
                  "SearXNG_Rubidium" = {
                    urls = [{
                      template = "http://192.168.0.37:8888/search";
                      params = [
                        { name = "q"; value = "{searchTerms}"; }
                      ];
                      }];
                  };
                  "SearXNG_Local" = {
                    urls = [{
                      template = "http://localhost:8888/search";
                      params = [
                        { name = "q"; value = "{searchTerms}"; }
                      ];
                      }];
                  };
                };
              };
            }; # }}}
          }; # }}}
        }; # }}}
      };
      home.packages = with pkgs; [
        firefox
      ];
    };
  };
}

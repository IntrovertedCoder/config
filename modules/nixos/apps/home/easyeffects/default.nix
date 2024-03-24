{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;
let cfg = config.plusultra.apps.home.easyeffects;
in
{
  options.plusultra.apps.home.easyeffects = with types; {
    enable = mkBoolOpt false "Whether or not to enable easyeffects.";
  };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ easyeffects ];
    # plusultra.home.extraOptions.home.packages = with pkgs; [ easyeffects ];
    plusultra.home.extraOptions.services.easyeffects = {
      enable = true;
      preset = "Harman IE 2019 V2 + Bass Bost";
    };
    plusultra.home.configFile = {
      # Harman {{{
      "easyeffects/output/Harman IE 2019 V2 + Bass Bost.json".text = ''
{
    "output": {
        "autogain#0": {
            "bypass": true,
            "input-gain": 0.0,
            "maximum-history": 15,
            "output-gain": 0.0,
            "reference": "Geometric Mean (MSI)",
            "silence-threshold": -70.0,
            "target": -30.0
        },
        "bass_enhancer#0": {
            "amount": 1.7,
            "blend": 0.0,
            "bypass": false,
            "floor": 20.0,
            "floor-active": false,
            "harmonics": 8.5,
            "input-gain": 0.0,
            "output-gain": -1.7,
            "scope": 150.0
        },
        "blocklist": [],
        "compressor#0": {
            "attack": 20.0,
            "boost-amount": 6.0,
            "boost-threshold": -72.0,
            "bypass": false,
            "dry": -100.0,
            "hpf-frequency": 200.0,
            "hpf-mode": "36 dB/oct",
            "input-gain": 0.0,
            "knee": -6.0,
            "lpf-frequency": 20000.0,
            "lpf-mode": "off",
            "makeup": 0.0,
            "mode": "Downward",
            "output-gain": 0.0,
            "ratio": 4.0,
            "release": 100.0,
            "release-threshold": -100.0,
            "sidechain": {
                "lookahead": 0.0,
                "mode": "RMS",
                "preamp": 0.0,
                "reactivity": 10.0,
                "source": "Middle",
                "stereo-split-source": "Left/Right",
                "type": "Feed-forward"
            },
            "stereo-split": false,
            "threshold": -40.0,
            "wet": 0.0
        },
        "compressor#1": {
            "attack": 20.0,
            "boost-amount": 6.0,
            "boost-threshold": -72.0,
            "bypass": false,
            "dry": -100.0,
            "hpf-frequency": 200.0,
            "hpf-mode": "36 dB/oct",
            "input-gain": 0.0,
            "knee": -6.0,
            "lpf-frequency": 20000.0,
            "lpf-mode": "off",
            "makeup": 0.0,
            "mode": "Upward",
            "output-gain": 0.0,
            "ratio": 4.0,
            "release": 100.0,
            "release-threshold": -100.0,
            "sidechain": {
                "lookahead": 0.0,
                "mode": "RMS",
                "preamp": 0.0,
                "reactivity": 10.0,
                "source": "Middle",
                "stereo-split-source": "Left/Right",
                "type": "Feed-forward"
            },
            "stereo-split": false,
            "threshold": -40.0,
            "wet": 0.0
        },
        "equalizer#0": {
            "balance": 0.0,
            "bypass": false,
            "input-gain": -10.4,
            "left": {
                "band0": {
                    "frequency": 43.0,
                    "gain": 0.8999999761581421,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 0.8999999761581421,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell",
                    "width": 4.0
                },
                "band1": {
                    "frequency": 150.0,
                    "gain": -0.20000000298023224,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 2.0,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell",
                    "width": 4.0
                },
                "band2": {
                    "frequency": 250.0,
                    "gain": -2.0,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 0.699999988079071,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell",
                    "width": 4.0
                },
                "band3": {
                    "frequency": 1600.0,
                    "gain": -2.4000000953674316,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 2.0,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell",
                    "width": 4.0
                },
                "band4": {
                    "frequency": 4000.0,
                    "gain": 3.0999999046325684,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 0.5,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell",
                    "width": 4.0
                },
                "band5": {
                    "frequency": 6700.0,
                    "gain": 4.599999904632568,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 2.0,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell",
                    "width": 4.0
                },
                "band6": {
                    "frequency": 7900.0,
                    "gain": -8.699999809265137,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 2.0,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell",
                    "width": 4.0
                },
                "band7": {
                    "frequency": 8300.0,
                    "gain": -3.200000047683716,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 2.0,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell",
                    "width": 4.0
                },
                "band8": {
                    "frequency": 11000.0,
                    "gain": 12.0,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 1.899999976158142,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell",
                    "width": 4.0
                }
            },
            "mode": "IIR",
            "num-bands": 9,
            "output-gain": 0.0,
            "pitch-left": 0.0,
            "pitch-right": 0.0,
            "right": {
                "band0": {
                    "frequency": 43.0,
                    "gain": 0.8999999761581421,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 0.8999999761581421,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell",
                    "width": 4.0
                },
                "band1": {
                    "frequency": 150.0,
                    "gain": -0.20000000298023224,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 2.0,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell",
                    "width": 4.0
                },
                "band2": {
                    "frequency": 250.0,
                    "gain": -2.0,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 0.699999988079071,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell",
                    "width": 4.0
                },
                "band3": {
                    "frequency": 1600.0,
                    "gain": -2.4000000953674316,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 2.0,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell",
                    "width": 4.0
                },
                "band4": {
                    "frequency": 4000.0,
                    "gain": 3.0999999046325684,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 0.5,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell",
                    "width": 4.0
                },
                "band5": {
                    "frequency": 6700.0,
                    "gain": 4.599999904632568,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 2.0,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell",
                    "width": 4.0
                },
                "band6": {
                    "frequency": 7900.0,
                    "gain": -8.699999809265137,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 2.0,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell",
                    "width": 4.0
                },
                "band7": {
                    "frequency": 8300.0,
                    "gain": -3.200000047683716,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 2.0,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell",
                    "width": 4.0
                },
                "band8": {
                    "frequency": 11000.0,
                    "gain": 12.0,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 1.899999976158142,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell",
                    "width": 4.0
                }
            },
            "split-channels": false
        },
        "plugins_order": [
            "equalizer#0",
            "bass_enhancer#0",
            "compressor#0",
            "compressor#1",
            "autogain#0"
        ]
    }
}

      ''; # }}}
      # IEF {{{
      "easyeffects/output/IEF Neutral + Bass Bost.json".text = ''
        {
    "output": {
        "autogain": {
            "bypass": false,
            "input-gain": 0.0,
            "maximum-history": 15,
            "output-gain": 0.0,
            "reference": "Geometric Mean (MSI)",
            "target": -30.0
        },
        "bass_enhancer": {
            "amount": 5.0,
            "blend": 0.0,
            "bypass": false,
            "floor": 20.0,
            "floor-active": false,
            "harmonics": 8.5,
            "input-gain": 0.0,
            "output-gain": 0.0,
            "scope": 100.0
        },
        "blocklist": [],
        "compressor": {
            "attack": 20.0,
            "boost-amount": 6.0,
            "boost-threshold": -72.0,
            "bypass": false,
            "dry": -100.0,
            "hpf-frequency": 10.0,
            "hpf-mode": "off",
            "input-gain": 0.0,
            "knee": -6.0,
            "lpf-frequency": 20000.0,
            "lpf-mode": "off",
            "makeup": 0.0,
            "mode": "Downward",
            "output-gain": 0.0,
            "ratio": 4.0,
            "release": 100.0,
            "release-threshold": -100.0,
            "sidechain": {
                "lookahead": 0.0,
                "mode": "RMS",
                "preamp": 0.0,
                "reactivity": 10.0,
                "source": "Middle",
                "type": "Feed-forward"
            },
            "threshold": -20.0,
            "wet": 0.0
        },
        "equalizer": {
            "balance": 0.0,
            "bypass": false,
            "input-gain": -14.3,
            "left": {
                "band0": {
                    "frequency": 20.0,
                    "gain": -1.7999999523162842,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 2.0,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band1": {
                    "frequency": 35.0,
                    "gain": -7.900000095367432,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 0.5,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band2": {
                    "frequency": 39.0,
                    "gain": 1.0,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 1.399999976158142,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band3": {
                    "frequency": 120.0,
                    "gain": -0.6000000238418579,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 1.0,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band4": {
                    "frequency": 670.0,
                    "gain": 0.5,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 0.800000011920929,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band5": {
                    "frequency": 4200.0,
                    "gain": -1.2999999523162842,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 2.0,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band6": {
                    "frequency": 8100.0,
                    "gain": -12.0,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 2.0,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band7": {
                    "frequency": 10000.0,
                    "gain": 5.0,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 0.5,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band8": {
                    "frequency": 12000.0,
                    "gain": 12.0,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 1.899999976158142,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                }
            },
            "mode": "IIR",
            "num-bands": 9,
            "output-gain": 0.0,
            "pitch-left": 0.0,
            "pitch-right": 0.0,
            "right": {
                "band0": {
                    "frequency": 20.0,
                    "gain": -1.7999999523162842,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 2.0,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band1": {
                    "frequency": 35.0,
                    "gain": -7.900000095367432,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 0.5,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band2": {
                    "frequency": 39.0,
                    "gain": 1.0,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 1.399999976158142,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band3": {
                    "frequency": 120.0,
                    "gain": -0.6000000238418579,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 1.0,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band4": {
                    "frequency": 670.0,
                    "gain": 0.5,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 0.800000011920929,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band5": {
                    "frequency": 4200.0,
                    "gain": -1.2999999523162842,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 2.0,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band6": {
                    "frequency": 8100.0,
                    "gain": -12.0,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 2.0,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band7": {
                    "frequency": 10000.0,
                    "gain": 5.0,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 0.5,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band8": {
                    "frequency": 12000.0,
                    "gain": 12.0,
                    "mode": "APO (DR)",
                    "mute": false,
                    "q": 1.899999976158142,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                }
            },
            "split-channels": false
        },
        "plugins_order": [
            "bass_enhancer",
            "equalizer",
            "compressor",
            "autogain"
        ]
    }
        }
        ''; # }}}
        # Microphone {{{
      "easyeffects/input/Microphone.json".text = ''
        {
    "input": {
        "autogain": {
            "bypass": false,
            "input-gain": 0.0,
            "maximum-history": 6,
            "output-gain": 0.0,
            "reference": "Geometric Mean (MSI)",
            "target": -23.0
        },
        "bass_enhancer": {
            "amount": 4.0,
            "blend": 0.0,
            "bypass": false,
            "floor": 20.0,
            "floor-active": false,
            "harmonics": 8.5,
            "input-gain": 0.0,
            "output-gain": 0.0,
            "scope": 200.0
        },
        "blocklist": [],
        "compressor": {
            "attack": 10.0,
            "boost-amount": 6.0,
            "boost-threshold": -72.0,
            "bypass": false,
            "dry": -100.0,
            "hpf-frequency": 10.0,
            "hpf-mode": "off",
            "input-gain": 0.0,
            "knee": -6.0,
            "lpf-frequency": 20000.0,
            "lpf-mode": "off",
            "makeup": 0.0,
            "mode": "Downward",
            "output-gain": 0.0,
            "ratio": 4.0,
            "release": 100.0,
            "release-threshold": -100.0,
            "sidechain": {
                "lookahead": 0.0,
                "mode": "RMS",
                "preamp": 0.0,
                "reactivity": 10.0,
                "source": "Middle",
                "type": "Feed-forward"
            },
            "threshold": -25.0,
            "wet": 0.0
        },
        "equalizer": {
            "balance": 0.0,
            "bypass": false,
            "input-gain": 0.0,
            "left": {
                "band0": {
                    "frequency": 22.409377607517197,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127273,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band1": {
                    "frequency": 27.808642868112116,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.6504494641272744,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band10": {
                    "frequency": 194.0572151681383,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127275,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band11": {
                    "frequency": 240.8129260484642,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127273,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band12": {
                    "frequency": 298.8338532106506,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127273,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band13": {
                    "frequency": 370.83421264003283,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127275,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band14": {
                    "frequency": 460.1821774436494,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127275,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band15": {
                    "frequency": 571.0574408147727,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127273,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band16": {
                    "frequency": 708.6467418652917,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127276,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band17": {
                    "frequency": 879.3865010143169,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127275,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band18": {
                    "frequency": 1091.2639154039962,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127274,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band19": {
                    "frequency": 1354.190599570589,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127274,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band2": {
                    "frequency": 34.50879501029933,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.6504494641272744,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band20": {
                    "frequency": 1680.4662502621554,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127275,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band21": {
                    "frequency": 2085.3540256191577,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127274,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band22": {
                    "frequency": 2587.794554926422,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.6504494641272744,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band23": {
                    "frequency": 3211.291980275887,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.6504494641272744,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band24": {
                    "frequency": 3985.013479123514,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127273,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band25": {
                    "frequency": 4945.153703348953,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127274,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band26": {
                    "frequency": 6136.627963206924,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127276,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band27": {
                    "frequency": 7615.173363228385,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127277,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band28": {
                    "frequency": 9449.956181100773,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127276,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band29": {
                    "frequency": 11726.807462577064,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127276,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band3": {
                    "frequency": 42.82326680632096,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.6504494641272744,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band30": {
                    "frequency": 14552.238193376936,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127275,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band31": {
                    "frequency": 18058.421877614823,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127276,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band4": {
                    "frequency": 53.14100881870938,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.6504494641272744,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band5": {
                    "frequency": 65.9446844875766,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127276,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band6": {
                    "frequency": 81.83324910149196,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127273,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band7": {
                    "frequency": 101.5499688950431,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.6504494641272744,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band8": {
                    "frequency": 126.01719100502156,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.6504494641272744,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band9": {
                    "frequency": 156.3794908219932,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127275,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                }
            },
            "mode": "IIR",
            "num-bands": 32,
            "output-gain": 0.0,
            "pitch-left": 0.0,
            "pitch-right": 0.0,
            "right": {
                "band0": {
                    "frequency": 22.409377607517197,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127273,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band1": {
                    "frequency": 27.808642868112116,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.6504494641272744,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band10": {
                    "frequency": 194.0572151681383,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127275,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band11": {
                    "frequency": 240.8129260484642,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127273,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band12": {
                    "frequency": 298.8338532106506,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127273,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band13": {
                    "frequency": 370.83421264003283,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127275,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band14": {
                    "frequency": 460.1821774436494,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127275,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band15": {
                    "frequency": 571.0574408147727,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127273,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band16": {
                    "frequency": 708.6467418652917,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127276,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band17": {
                    "frequency": 879.3865010143169,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127275,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band18": {
                    "frequency": 1091.2639154039962,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127274,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band19": {
                    "frequency": 1354.190599570589,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127274,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band2": {
                    "frequency": 34.50879501029933,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.6504494641272744,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band20": {
                    "frequency": 1680.4662502621554,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127275,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band21": {
                    "frequency": 2085.3540256191577,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127274,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band22": {
                    "frequency": 2587.794554926422,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.6504494641272744,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band23": {
                    "frequency": 3211.291980275887,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.6504494641272744,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band24": {
                    "frequency": 3985.013479123514,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127273,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band25": {
                    "frequency": 4945.153703348953,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127274,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band26": {
                    "frequency": 6136.627963206924,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127276,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band27": {
                    "frequency": 7615.173363228385,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127277,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band28": {
                    "frequency": 9449.956181100773,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127276,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band29": {
                    "frequency": 11726.807462577064,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127276,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band3": {
                    "frequency": 42.82326680632096,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.6504494641272744,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band30": {
                    "frequency": 14552.238193376936,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127275,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band31": {
                    "frequency": 18058.421877614823,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127276,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band4": {
                    "frequency": 53.14100881870938,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.6504494641272744,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band5": {
                    "frequency": 65.9446844875766,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127276,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band6": {
                    "frequency": 81.83324910149196,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127273,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band7": {
                    "frequency": 101.5499688950431,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.6504494641272744,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band8": {
                    "frequency": 126.01719100502156,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.6504494641272744,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                },
                "band9": {
                    "frequency": 156.3794908219932,
                    "gain": 0.0,
                    "mode": "RLC (BT)",
                    "mute": false,
                    "q": 4.650449464127275,
                    "slope": "x1",
                    "solo": false,
                    "type": "Bell"
                }
            },
            "split-channels": false
        },
        "gate": {
            "attack": 20.0,
            "bypass": false,
            "curve-threshold": -30.0,
            "curve-zone": -6.0,
            "dry": -100.0,
            "hpf-frequency": 10.0,
            "hpf-mode": "off",
            "hysteresis": false,
            "hysteresis-threshold": -12.0,
            "hysteresis-zone": -6.0,
            "input-gain": 0.0,
            "lpf-frequency": 20000.0,
            "lpf-mode": "off",
            "makeup": 0.0,
            "output-gain": 0.0,
            "reduction": -72.0,
            "release": 400.0,
            "sidechain": {
                "input": "Internal",
                "lookahead": 0.0,
                "mode": "RMS",
                "preamp": 0.0,
                "reactivity": 10.0,
                "source": "Middle"
            },
            "wet": 0.0
        },
        "plugins_order": [
            "bass_enhancer",
            "equalizer",
            "gate",
            "compressor",
            "autogain"
        ]
    }
        }
        ''; # }}}
    };
    plusultra.desktop.Hyprland.easyeffects = "exec-once = easyeffects --gapplication-service";
  };
}

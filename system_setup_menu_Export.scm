{
  "graph": {
    "cells": [
      {
        "position": {
          "x": 0,
          "y": 0
        },
        "size": {
          "height": 10,
          "width": 10
        },
        "type": "Statechart",
        "id": "00ffb6d1-d225-4bc0-8b73-7df9987f57b7",
        "attrs": {
          "name": {
            "text": "system_setup_menu Export Export"
          },
          "specification": {
            "text": "@EventDriven\n@SuperSteps(no)\n\ninterface:\n    in event EV_SYS_ENTER\n    in event EV_SYS_ESCAPE\n    in event EV_SYS_NEXT\n    \n    \n    \n    var index: integer = 0\n    var motor = 0"
          }
        },
        "z": 1
      },
      {
        "position": {
          "x": -24,
          "y": -15
        },
        "size": {
          "height": 60,
          "width": 93
        },
        "type": "State",
        "attrs": {
          "name": {
            "text": "ST_SYS_MENU_1",
            "fontSize": 11
          }
        },
        "id": "ff893394-14d0-4941-a767-817aaa23bfbb",
        "z": 3,
        "embeds": [
          "f6f13e7d-6e3c-4311-bdb0-e82c95d0d414"
        ]
      },
      {
        "position": {
          "x": -264,
          "y": -15
        },
        "size": {
          "height": 60,
          "width": 101
        },
        "type": "State",
        "attrs": {
          "name": {
            "text": "ST_SYS_MENU_2",
            "fontSize": 11
          }
        },
        "id": "82bd98bd-1156-4868-803b-e9a72c594e7f",
        "z": 23,
        "embeds": [
          "8d9ee1e2-a1f5-4de0-b314-f5ff6c90c7fd"
        ]
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "ff893394-14d0-4941-a767-817aaa23bfbb"
        },
        "target": {
          "id": "82bd98bd-1156-4868-803b-e9a72c594e7f",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "89.109%",
              "dy": "28.333%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "EV_SYS_ENTER / \n    index = 0"
              }
            },
            "position": {
              "distance": 0.5359712230215827,
              "offset": 14,
              "angle": 0
            }
          },
          {
            "attrs": {
              "label": {
                "text": "2"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "d1aa9e00-2d3f-47f6-9c53-530acf803c30",
        "z": 26,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
      },
      {
        "position": {
          "x": -404,
          "y": 13
        },
        "size": {
          "width": 15,
          "height": 15
        },
        "type": "Choice",
        "attrs": {},
        "id": "3e15a30c-d15f-45d5-8373-8f9e6632d8e0",
        "z": 29
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "82bd98bd-1156-4868-803b-e9a72c594e7f"
        },
        "target": {
          "id": "3e15a30c-d15f-45d5-8373-8f9e6632d8e0"
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "EV_SYS_ENTER"
              }
            },
            "position": {
              "distance": 0.6917341546805097,
              "offset": 34,
              "angle": 0
            }
          },
          {
            "attrs": {
              "label": {
                "text": "2"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "5e4a40a1-a8af-462d-a3a7-ca18de092ba8",
        "z": 30,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "ff893394-14d0-4941-a767-817aaa23bfbb"
        },
        "target": {
          "id": "ff893394-14d0-4941-a767-817aaa23bfbb",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "94.624%",
              "dy": "50%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "EV_SYS_NEXT /\n    motor = (motor % MOTORS) + 1"
              }
            },
            "position": {
              "distance": 0.4451858433497833,
              "offset": -98.6768569946289,
              "angle": 0
            }
          },
          {
            "attrs": {
              "label": {
                "text": "3"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "f6f13e7d-6e3c-4311-bdb0-e82c95d0d414",
        "z": 37,
        "router": {
          "name": "orthogonal"
        },
        "vertices": [
          {
            "x": 92,
            "y": 15
          }
        ],
        "parent": "ff893394-14d0-4941-a767-817aaa23bfbb"
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "82bd98bd-1156-4868-803b-e9a72c594e7f"
        },
        "target": {
          "id": "82bd98bd-1156-4868-803b-e9a72c594e7f",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "95.05%",
              "dy": "86.667%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "EV_SYS_NEXT / \n    index = (index + 1) % size(parameters)"
              }
            },
            "position": {
              "distance": 0.6171698554672309,
              "offset": 23.626073728961874,
              "angle": 0
            }
          },
          {
            "attrs": {
              "label": {
                "text": "3"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "8d9ee1e2-a1f5-4de0-b314-f5ff6c90c7fd",
        "z": 38,
        "router": {
          "name": "orthogonal"
        },
        "vertices": [],
        "parent": "82bd98bd-1156-4868-803b-e9a72c594e7f"
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "82bd98bd-1156-4868-803b-e9a72c594e7f"
        },
        "target": {
          "id": "ff893394-14d0-4941-a767-817aaa23bfbb",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "1.075%",
              "dy": "58.333%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "EV_SYS_ESCAPE"
              }
            },
            "position": {
              "distance": 0.4784172661870504,
              "offset": 14,
              "angle": 0
            }
          },
          {
            "attrs": {
              "label": {
                "text": "1"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "37781e05-76ba-4125-ad3d-1c3281e60e01",
        "z": 39,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
      },
      {
        "position": {
          "x": 138,
          "y": -151
        },
        "size": {
          "height": 18,
          "width": 18
        },
        "type": "Entry",
        "entryKind": "Initial",
        "attrs": {},
        "id": "b0a05d31-8021-481d-95b2-817f2c36e21d",
        "z": 58,
        "embeds": [
          "4ff858d9-5715-4115-9a1e-599120cb6fb4"
        ]
      },
      {
        "type": "NodeLabel",
        "label": true,
        "size": {
          "width": 15,
          "height": 15
        },
        "position": {
          "x": 138,
          "y": -136
        },
        "attrs": {
          "label": {
            "refX": "50%",
            "textAnchor": "middle",
            "refY": "50%",
            "textVerticalAnchor": "middle"
          }
        },
        "id": "4ff858d9-5715-4115-9a1e-599120cb6fb4",
        "z": 59,
        "parent": "b0a05d31-8021-481d-95b2-817f2c36e21d"
      },
      {
        "position": {
          "x": -660,
          "y": -231
        },
        "size": {
          "height": 60,
          "width": 93
        },
        "type": "State",
        "attrs": {
          "name": {
            "text": "ST_SYS_SPIN",
            "fontSize": 11
          }
        },
        "id": "4691a33e-6d10-4f7d-95e1-db6cae0455f3",
        "z": 72,
        "embeds": [
          "27c1f99a-a252-46be-8cf2-fe38d8f3769e"
        ]
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "3e15a30c-d15f-45d5-8373-8f9e6632d8e0"
        },
        "target": {
          "id": "4691a33e-6d10-4f7d-95e1-db6cae0455f3",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "88.333%",
              "dy": "80%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "[index == 2]"
              }
            },
            "position": {
              "distance": 0.701332071421109,
              "offset": 11,
              "angle": 0
            }
          },
          {
            "attrs": {
              "label": {
                "text": "3"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "03270f1c-909a-46fa-9c02-fe5dd9ec8077",
        "z": 73,
        "router": {
          "name": "orthogonal"
        },
        "vertices": [
          {
            "x": -460,
            "y": -183
          }
        ]
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "4691a33e-6d10-4f7d-95e1-db6cae0455f3"
        },
        "target": {
          "id": "4691a33e-6d10-4f7d-95e1-db6cae0455f3",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "1.075%",
              "dy": "60%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "EV_SYS_NEXT /\n    spin == 0 ? \n    spin = 1 : spin = 0"
              }
            },
            "position": {
              "distance": 0.7292953522737499,
              "offset": 70.1923828125,
              "angle": 0
            }
          },
          {
            "attrs": {
              "label": {
                "text": "1"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "27c1f99a-a252-46be-8cf2-fe38d8f3769e",
        "z": 86,
        "router": {
          "name": "orthogonal"
        },
        "vertices": [],
        "parent": "4691a33e-6d10-4f7d-95e1-db6cae0455f3"
      },
      {
        "type": "Note",
        "attrs": {
          "root": {
            "display": ""
          },
          "body": {
            "filter": {
              "args": {}
            }
          },
          "label": {
            "text": "[{power: ON, speed: 5, spin: LEFT}, {power:off, speed: 3, spin: RIGHT}]"
          }
        },
        "position": {
          "x": -399,
          "y": -620
        },
        "size": {
          "width": 478.4375,
          "height": 60
        },
        "angle": 0,
        "linkable": false,
        "id": "6e6f25cf-d741-4953-8885-6d6e19e0f145",
        "z": 90
      },
      {
        "position": {
          "x": -29,
          "y": -173
        },
        "size": {
          "height": 60,
          "width": 113
        },
        "type": "State",
        "attrs": {
          "name": {
            "text": "ST_SYS_MAIN",
            "fontSize": 11
          },
          "specification": {
            "text": "entry / motor = 1"
          }
        },
        "id": "861d07a8-eaaa-4a29-a5f4-4f6a71aa1fe1",
        "z": 91
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "4691a33e-6d10-4f7d-95e1-db6cae0455f3",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "75.269%",
              "dy": "13.333%",
              "rotate": true
            }
          },
          "priority": true
        },
        "target": {
          "id": "861d07a8-eaaa-4a29-a5f4-4f6a71aa1fe1",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "46.903%",
              "dy": "31.667%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "EV_SYS_ENTER /\n    motors[index]->power = power\n    motors[index]->speed = speed\n    motors[index]->spin = spin"
              }
            },
            "position": {
              "distance": 0.39908426243874984,
              "offset": -27,
              "angle": 0
            }
          },
          {
            "attrs": {
              "label": {
                "text": "2"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "fc54fb86-6d83-435e-abd3-b3ce9d157df3",
        "z": 92,
        "router": {
          "name": "orthogonal"
        },
        "vertices": [
          {
            "x": -580,
            "y": -307
          },
          {
            "x": -545,
            "y": -307
          }
        ]
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "b0a05d31-8021-481d-95b2-817f2c36e21d"
        },
        "target": {
          "id": "861d07a8-eaaa-4a29-a5f4-4f6a71aa1fe1",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "18.627%",
              "dy": "48.333%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {},
            "position": {}
          },
          {
            "attrs": {
              "label": {
                "text": "1"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "ad7b35eb-7b4a-42c5-8bbc-202bc825f25b",
        "z": 92,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "ff893394-14d0-4941-a767-817aaa23bfbb"
        },
        "target": {
          "id": "861d07a8-eaaa-4a29-a5f4-4f6a71aa1fe1",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "27.451%",
              "dy": "70%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "EV_SYS_ESCAPE"
              }
            },
            "position": {
              "distance": 0.32105263157894737,
              "offset": -43,
              "angle": 0
            }
          },
          {
            "attrs": {
              "label": {
                "text": "1"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "c069e62f-f137-489e-af62-027172041f33",
        "z": 92,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "861d07a8-eaaa-4a29-a5f4-4f6a71aa1fe1",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "53.922%",
              "dy": "98.333%",
              "rotate": true
            }
          },
          "priority": true
        },
        "target": {
          "id": "ff893394-14d0-4941-a767-817aaa23bfbb",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "61.29%",
              "dy": "0%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "EV_SYS_ENTER"
              }
            },
            "position": {
              "distance": 0.47113004185228935,
              "offset": -39.035,
              "angle": 0
            }
          },
          {
            "attrs": {
              "label": {
                "text": "1"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "21a93305-2b5d-4ee0-a042-03c3fac0951e",
        "z": 92,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
      },
      {
        "position": {
          "x": -661,
          "y": -121
        },
        "size": {
          "height": 60,
          "width": 95
        },
        "type": "State",
        "attrs": {
          "name": {
            "text": "ST_SYS_SPEED",
            "fontSize": 11
          }
        },
        "id": "cbec0a06-9e5c-4322-a849-e7c7df873089",
        "z": 97,
        "embeds": [
          "25d9cf52-3bcb-4181-a8c8-a670a112dbf5"
        ]
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "3e15a30c-d15f-45d5-8373-8f9e6632d8e0"
        },
        "target": {
          "id": "cbec0a06-9e5c-4322-a849-e7c7df873089",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "61.667%",
              "dy": "48.333%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "[index == 1]"
              }
            },
            "position": {
              "distance": 0.5809323339015039,
              "offset": 10,
              "angle": 0
            }
          },
          {
            "attrs": {
              "label": {
                "text": "2"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "1b666fdf-7193-4c67-a6ef-1c8300cf8006",
        "z": 98,
        "router": {
          "name": "orthogonal"
        },
        "vertices": [
          {
            "x": -481,
            "y": -92
          }
        ]
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "cbec0a06-9e5c-4322-a849-e7c7df873089"
        },
        "target": {
          "id": "cbec0a06-9e5c-4322-a849-e7c7df873089",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "0%",
              "dy": "73.333%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "EV_SYS_NEXT\n    speed = speed % (MAX_SPEED + 1)"
              }
            },
            "position": {
              "distance": 0.7163074621906188,
              "offset": 102.5572509765625,
              "angle": 0
            }
          },
          {
            "attrs": {
              "label": {
                "text": "1"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "25d9cf52-3bcb-4181-a8c8-a670a112dbf5",
        "z": 98,
        "router": {
          "name": "orthogonal"
        },
        "vertices": [],
        "parent": "cbec0a06-9e5c-4322-a849-e7c7df873089"
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "cbec0a06-9e5c-4322-a849-e7c7df873089"
        },
        "target": {
          "id": "861d07a8-eaaa-4a29-a5f4-4f6a71aa1fe1",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "12.389%",
              "dy": "50%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {},
            "position": {}
          },
          {
            "attrs": {
              "label": {
                "text": "2"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "7de784db-cd14-4c78-bfc4-c75f8eb4395c",
        "z": 102,
        "router": {
          "name": "orthogonal"
        },
        "vertices": [
          {
            "x": -898,
            "y": -37
          },
          {
            "x": -571,
            "y": -307
          }
        ]
      },
      {
        "position": {
          "x": -659.5,
          "y": -9.5
        },
        "size": {
          "height": 60,
          "width": 92
        },
        "type": "State",
        "attrs": {
          "name": {
            "text": "ST_SYS_POWER",
            "fontSize": 11
          }
        },
        "id": "3369619b-01a3-471a-8c74-afb9b50b34aa",
        "z": 103,
        "embeds": [
          "503ce043-5228-4785-87a3-c8de161ea31b"
        ]
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "3e15a30c-d15f-45d5-8373-8f9e6632d8e0"
        },
        "target": {
          "id": "3369619b-01a3-471a-8c74-afb9b50b34aa",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "96.739%",
              "dy": "58.333%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "[index == 0]"
              }
            },
            "position": {
              "distance": 0.48261791951177335,
              "offset": 12.941864013671875,
              "angle": 0
            }
          },
          {
            "attrs": {
              "label": {
                "text": "1"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "55e53b31-3b1b-4d96-883a-d25150a36961",
        "z": 104,
        "router": {
          "name": "orthogonal"
        },
        "vertices": [
          {
            "x": -478,
            "y": 20.53
          }
        ]
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "3369619b-01a3-471a-8c74-afb9b50b34aa",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "9.239%",
              "dy": "91.667%",
              "rotate": true
            }
          },
          "priority": true
        },
        "target": {
          "id": "861d07a8-eaaa-4a29-a5f4-4f6a71aa1fe1",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "61.947%",
              "dy": "23.333%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {},
            "position": {}
          },
          {
            "attrs": {
              "label": {
                "text": "3"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "fdcb8c52-ff0a-43db-b9fa-0d060d45782b",
        "z": 104,
        "router": {
          "name": "orthogonal"
        },
        "vertices": [
          {
            "x": -898,
            "y": 40
          },
          {
            "x": -719,
            "y": -307
          }
        ]
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "3369619b-01a3-471a-8c74-afb9b50b34aa"
        },
        "target": {
          "id": "82bd98bd-1156-4868-803b-e9a72c594e7f",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "4.95%",
              "dy": "71.667%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "EV_SYS_ESCAPE"
              }
            },
            "position": {
              "distance": 0.5201186125946343,
              "offset": 18,
              "angle": 0
            }
          },
          {
            "attrs": {
              "label": {
                "text": "2"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "9d9da1ff-3e9b-4a84-b2bb-88fd545f7d13",
        "z": 104,
        "router": {
          "name": "orthogonal"
        },
        "vertices": [
          {
            "x": -484,
            "y": 179
          }
        ]
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "3369619b-01a3-471a-8c74-afb9b50b34aa"
        },
        "target": {
          "id": "3369619b-01a3-471a-8c74-afb9b50b34aa",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "5.435%",
              "dy": "81.667%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "EV_SYS_NEXT /\n    power == 0 ? \n    power = 1 : power = 0"
              }
            },
            "position": {
              "distance": 0.6479923768114294,
              "offset": 72.8760986328125,
              "angle": 0
            }
          },
          {
            "attrs": {
              "label": {
                "text": "1"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "503ce043-5228-4785-87a3-c8de161ea31b",
        "z": 104,
        "router": {
          "name": "orthogonal"
        },
        "vertices": [],
        "parent": "3369619b-01a3-471a-8c74-afb9b50b34aa"
      }
    ]
  },
  "genModel": {
    "generator": {
      "type": "create::c",
      "features": {
        "Outlet": {
          "targetProject": "",
          "targetFolder": "",
          "libraryTargetFolder": "",
          "skipLibraryFiles": "",
          "apiTargetFolder": ""
        },
        "LicenseHeader": {
          "licenseText": ""
        },
        "FunctionInlining": {
          "inlineReactions": false,
          "inlineEntryActions": false,
          "inlineExitActions": false,
          "inlineEnterSequences": false,
          "inlineExitSequences": false,
          "inlineChoices": false,
          "inlineEnterRegion": false,
          "inlineExitRegion": false,
          "inlineEntries": false
        },
        "OutEventAPI": {
          "observables": false,
          "getters": false
        },
        "IdentifierSettings": {
          "moduleName": "SystemSetupMenuExport",
          "statemachinePrefix": "systemSetupMenuExport",
          "separator": "_",
          "headerFilenameExtension": "h",
          "sourceFilenameExtension": "c"
        },
        "Tracing": {
          "enterState": false,
          "exitState": false,
          "generic": false
        },
        "Includes": {
          "useRelativePaths": false,
          "generateAllSpecifiedIncludes": false
        },
        "GeneratorOptions": {
          "userAllocatedQueue": false,
          "metaSource": false
        },
        "GeneralFeatures": {
          "timerService": false,
          "timerServiceTimeType": ""
        },
        "Debug": {
          "dumpSexec": false
        }
      }
    }
  }
}
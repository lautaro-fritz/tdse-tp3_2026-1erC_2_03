{
  "graph": {
    "cells": [
      {
        "position": {
          "x": 579,
          "y": 392
        },
        "size": {
          "width": 170,
          "height": 60
        },
        "type": "State",
        "attrs": {
          "name": {
            "text": " Export",
            "fontSize": 11
          },
          "specification": {
            "text": "entry / column = 0, row = 0"
          }
        },
        "id": "67834e20-a10b-4d7c-81a0-bfc746ff816a",
        "z": 1
      },
      {
        "position": {
          "x": 946,
          "y": 386
        },
        "size": {
          "width": 138,
          "height": 102
        },
        "type": "State",
        "attrs": {
          "name": {
            "text": "ST_DSP_UPDATE",
            "fontSize": 11
          },
          "specification": {
            "text": "\nentry / raise EV_ACT_WRITE_CHAR\n[column == COLUMNS] / column = 0, row++"
          }
        },
        "id": "9566963b-5adf-42b8-ab1b-bc5ed15a7eac",
        "z": 19,
        "embeds": [
          "4ecad36e-92a6-4d39-a491-aa326a494471"
        ]
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "9566963b-5adf-42b8-ab1b-bc5ed15a7eac"
        },
        "target": {
          "id": "9566963b-5adf-42b8-ab1b-bc5ed15a7eac",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "87.736%",
              "dy": "35%",
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
                "text": "after 1ms [column < COLUMNS && rows < ROWS] / \ncolumn++"
              }
            },
            "position": {
              "distance": 0.49338849605555307,
              "offset": 23.994873046875,
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
        "id": "4ecad36e-92a6-4d39-a491-aa326a494471",
        "z": 36,
        "router": {
          "name": "orthogonal"
        },
        "vertices": [],
        "parent": "9566963b-5adf-42b8-ab1b-bc5ed15a7eac"
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "9566963b-5adf-42b8-ab1b-bc5ed15a7eac",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "32.544%",
              "dy": "100%",
              "rotate": true
            }
          },
          "priority": true
        },
        "target": {
          "id": "67834e20-a10b-4d7c-81a0-bfc746ff816a",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "28.235%",
              "dy": "83.333%",
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
                "text": "EV_DSP_IDLE / flag = false"
              }
            },
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
        "id": "588a3e92-300d-4462-a062-cb9babdfe3c3",
        "z": 37,
        "router": {
          "name": "orthogonal"
        },
        "vertices": [
          {
            "x": 798,
            "y": 509
          }
        ]
      },
      {
        "position": {
          "x": 491,
          "y": 413
        },
        "size": {
          "height": 18,
          "width": 18
        },
        "type": "Entry",
        "entryKind": "Initial",
        "attrs": {},
        "id": "ab4edb32-9f7e-4236-8be1-c3135f09c77d",
        "z": 38,
        "embeds": [
          "cf28ed96-c23e-48c3-949a-9f4bf7966a4d"
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
          "x": 491,
          "y": 428
        },
        "attrs": {
          "label": {
            "refX": "50%",
            "textAnchor": "middle",
            "refY": "50%",
            "textVerticalAnchor": "middle"
          }
        },
        "id": "cf28ed96-c23e-48c3-949a-9f4bf7966a4d",
        "z": 39,
        "parent": "ab4edb32-9f7e-4236-8be1-c3135f09c77d"
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "ab4edb32-9f7e-4236-8be1-c3135f09c77d"
        },
        "target": {
          "id": "67834e20-a10b-4d7c-81a0-bfc746ff816a",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "1.667%",
              "dy": "51.667%",
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
        "id": "25c635e9-fc46-4bb0-ae8e-3ee7d9f2c752",
        "z": 40,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "67834e20-a10b-4d7c-81a0-bfc746ff816a"
        },
        "target": {
          "id": "9566963b-5adf-42b8-ab1b-bc5ed15a7eac",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "1.449%",
              "dy": "33.333%",
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
                "text": "EV_DSP_UPDATE [flag == true]"
              }
            },
            "position": {
              "distance": 0.4949238578680203,
              "offset": -12,
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
        "id": "95feed00-bbad-4fe5-848a-18255438238c",
        "z": 41,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
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
          "moduleName": "MyStatechart",
          "statemachinePrefix": "myStatechart",
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
___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "GTM Consent Listener",
  "categories": [
    "UTILITY"
  ],
  "brand": {
    "id": "github.com_Ayudante",
    "displayName": "Ayudante"
  },
  "description": "With Consent Mode implemented in Google Tag Manager, a custom event is fired when the status changes.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "GROUP",
    "name": "consentTypes",
    "displayName": "Add change listener",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "ad_storage",
        "checkboxText": "ad_storage ( _on | _off )",
        "simpleValueType": true,
        "defaultValue": true,
        "alwaysInSummary": true
      },
      {
        "type": "CHECKBOX",
        "name": "ad_user_data",
        "checkboxText": "ad_user_data ( _on | _off )",
        "simpleValueType": true,
        "defaultValue": true,
        "alwaysInSummary": true
      },
      {
        "type": "CHECKBOX",
        "name": "ad_personalization",
        "checkboxText": "ad_personalization ( _on | _off )",
        "simpleValueType": true,
        "defaultValue": true,
        "alwaysInSummary": true
      },
      {
        "type": "CHECKBOX",
        "name": "analytics_storage",
        "checkboxText": "analytics_storage ( _on | _off )",
        "simpleValueType": true,
        "defaultValue": true,
        "alwaysInSummary": true
      },
      {
        "type": "CHECKBOX",
        "name": "functionality_storage",
        "checkboxText": "functionality_storage ( _on | _off )",
        "simpleValueType": true,
        "defaultValue": true,
        "alwaysInSummary": true
      },
      {
        "type": "CHECKBOX",
        "name": "personalization_storage",
        "checkboxText": "personalization_storage ( _on | _off )",
        "simpleValueType": true,
        "defaultValue": true,
        "alwaysInSummary": true
      },
      {
        "type": "CHECKBOX",
        "name": "security_storage",
        "checkboxText": "security_storage ( _on | _off )",
        "simpleValueType": true,
        "defaultValue": true,
        "alwaysInSummary": true
      },
      {
        "type": "SIMPLE_TABLE",
        "name": "custom",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "",
            "name": "name",
            "type": "TEXT",
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ],
            "isUnique": true
          }
        ],
        "newRowButtonText": "+ Add custom consent type"
      },
      {
        "type": "LABEL",
        "name": "Note",
        "displayName": "\u003cb\u003eNote\u003c/b\u003e: If you want to use a custom consent type, you need to add the \u003cb\u003eread permission\u003c/b\u003e of the consent type name you want to use to the access_consent permission of the custom tag template.\u003cbr\u003e\nIf the permission is not set, no custom event will be fired when the status of the custom consent type you set changes.",
        "enablingConditions": [
          {
            "paramName": "custom",
            "paramValue": "",
            "type": "PRESENT"
          }
        ]
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// ---- テンプレートAPI
//const log = require('logToConsole');
//log(data);
const queryPermission = require('queryPermission');
const addConsentListener = require('addConsentListener');
const createQueue = require('createQueue');
const dataLayerPush = createQueue('dataLayer');

// ---- ConsentListenerでdataLayer.pushする関数
const addConsent = function(cType){
	let wasCalled = false;
	addConsentListener(cType, (consentType, granted) => {
		if (wasCalled) return;  // 反応は1度だけ
		wasCalled = true;
		let changeState = '';
		switch(granted){
			case true:
				changeState = '_on';
				break;
			case false:
				changeState = '_off';
				break;
		}
		dataLayerPush({'event': consentType + changeState});
	});
};

// ---- 各同意タイプへイベントをバインド
const permissionCheck = function(cType){	// 権限＆ON/OFFチェック + イベントリスナーを追加する関数
	if (queryPermission('access_consent', cType, 'read') && data[cType]) {
		addConsent(cType);
	}
};
permissionCheck('ad_storage');
permissionCheck('ad_user_data');
permissionCheck('ad_personalization');
permissionCheck('analytics_storage');
permissionCheck('functionality_storage');
permissionCheck('personalization_storage');
permissionCheck('security_storage');
// -- Custom consent type
if(data.custom){
	data.custom.forEach(function(element){
		if (queryPermission('access_consent', element.name, 'read')) {
			addConsent(element.name);
		}
	});
}

// ---- タグの終了時に data.gtmOnSuccess を呼び出します。
data.gtmOnSuccess();


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "dataLayer"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_consent",
        "versionId": "1"
      },
      "param": [
        {
          "key": "consentTypes",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "analytics_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "functionality_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "personalization_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "security_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_user_data"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_personalization"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 2021/6/21 13:00:46



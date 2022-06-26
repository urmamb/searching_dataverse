class UsState {
  String stateCode;
  String stateName;

  UsState({required this.stateCode, required this.stateName});

  factory UsState.fromJson(Map<String, dynamic> json) {
    return UsState(stateCode: json['stateCode'], stateName: json['stateName']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stateCode'] = stateCode;
    data['stateName'] = stateName;
    return data;
  }
}

var allStates = '''[
  {
    "stateCode" : "AL",
    "stateName" : "Alabama"
  },
  {
    "stateCode" : "AK",
    "stateName" : "Alaska"
  },
  {
    "stateCode" : "AA",
    "stateName" : "APO - AA"
  },
  {
    "stateCode" : "AE",
    "stateName" : "APO - AE"
  },
  {
    "stateCode" : "AP",
    "stateName" : "APO - AP"
  },
  {
    "stateCode" : "AZ",
    "stateName" : "Arizona"
  },
  {
    "stateCode" : "AR",
    "stateName" : "Arkansas"
  },
  {
    "stateCode" : "CA",
    "stateName" : "California"
  },
  {
    "stateCode" : "CO",
    "stateName" : "Colorado"
  },
  {
    "stateCode" : "CT",
    "stateName" : "Connecticut"
  },
  {
    "stateCode" : "DE",
    "stateName" : "Delaware"
  },
  {
    "stateCode" : "DC",
    "stateName" : "District of Columbia"
  },
  {
    "stateCode" : "FL",
    "stateName" : "Florida"
  },
  {
    "stateCode" : "GA",
    "stateName" : "Georgia"
  },
  {
    "stateCode" : "HI",
    "stateName" : "Hawaii"
  },
  {
    "stateCode" : "ID",
    "stateName" : "Idaho"
  },
  {
    "stateCode" : "IL",
    "stateName" : "Illinois"
  },
  {
    "stateCode" : "IN",
    "stateName" : "Indiana"
  },
  {
    "stateCode" : "IA",
    "stateName" : "Iowa"
  },
  {
    "stateCode" : "KS",
    "stateName" : "Kansas"
  },
  {
    "stateCode" : "KY",
    "stateName" : "Kentucky"
  },
  {
    "stateCode" : "LA",
    "stateName" : "Louisiana"
  },
  {
    "stateCode" : "ME",
    "stateName" : "Maine"
  },
  {
    "stateCode" : "MD",
    "stateName" : "Maryland"
  },
  {
    "stateCode" : "MA",
    "stateName" : "Massachusetts"
  },
  {
    "stateCode" : "MI",
    "stateName" : "Michigan"
  },
  {
    "stateCode" : "MN",
    "stateName" : "Minnesota"
  },
  {
    "stateCode" : "MS",
    "stateName" : "Mississippi"
  },
  {
    "stateCode" : "MO",
    "stateName" : "Missouri"
  },
  {
    "stateCode" : "MT",
    "stateName" : "Montana"
  },
  {
    "stateCode" : "NE",
    "stateName" : "Nebraska"
  },
  {
    "stateCode" : "NV",
    "stateName" : "Nevada"
  },
  {
    "stateCode" : "NH",
    "stateName" : "New Hampshire"
  },
  {
    "stateCode" : "NJ",
    "stateName" : "New Jersey"
  },
  {
    "stateCode" : "NM",
    "stateName" : "New Mexico"
  },
  {
    "stateCode" : "NY",
    "stateName" : "New York"
  },
  {
    "stateCode" : "NC",
    "stateName" : "North Carolina"
  },
  {
    "stateCode" : "ND",
    "stateName" : "North Dakota"
  },
  {
    "stateCode" : "OH",
    "stateName" : "Ohio"
  },
  {
    "stateCode" : "OK",
    "stateName" : "Oklahoma"
  },
  {
    "stateCode" : "OR",
    "stateName" : "Oregon"
  },
  {
    "stateCode" : "PA",
    "stateName" : "Pennsylvania"
  },
  {
    "stateCode" : "RI",
    "stateName" : "Rhode Island"
  },
  {
    "stateCode" : "SC",
    "stateName" : "South Carolina"
  },
  {
    "stateCode" : "SD",
    "stateName" : "South Dakota"
  },
  {
    "stateCode" : "TN",
    "stateName" : "Tennessee"
  },
  {
    "stateCode" : "TX",
    "stateName" : "Texas"
  },
  {
    "stateCode" : "UT",
    "stateName" : "Utah"
  },
  {
    "stateCode" : "VT",
    "stateName" : "Vermont"
  },
  {
    "stateCode" : "VA",
    "stateName" : "Virginia"
  },
  {
    "stateCode" : "WA",
    "stateName" : "Washington"
  },
  {
    "stateCode" : "WV",
    "stateName" : "West Virginia"
  },
  {
    "stateCode" : "WI",
    "stateName" : "Wisconsin"
  },
  {
    "stateCode" : "WY",
    "stateName" : "Wyoming"
  }
]''';

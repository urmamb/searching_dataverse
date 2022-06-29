// Needs to be a var at the top level to get hoisted to global scope.
// https://stackoverflow.com/questions/28776079/do-let-statements-create-properties-on-the-global-object/28776236#28776236
var aadOauth = (function () {


//   let myMSALObj = null;
//   let authResult = null;

//   const tokenRequest = {
//     scopes: null,
//     // Hardcoded?
//     prompt: null,
//   };
    var user, authContext, message, errorMessage, organizationURI, tenant, clientId, pageUrl;

  // Initialise the myMSALObj for the given client, authority and scope
  function init(config) {

    //Set these variables to match your environment
     organizationURI = config.resource; //The URL of your Dataverse organization
     tenant = config.tenant; //The name of the Azure AD organization you use
     clientId = config.clientId; //The ClientId you got when you registered the application
     pageUrl = config.redirectUri; //The URL of this page in your development environment when debugging.


    //Configuration data for AuthenticationContext
    var endpoints = {
        orgUri: organizationURI
    };

    window.config = {
        tenant: tenant,
        clientId: clientId,
        postLogoutRedirectUri: pageUrl,
        endpoints: endpoints,
        cacheLocation: 'localStorage',
    };

    authenticate();
  }

   function login() {
    authContext.login();
   }


  function getAccount() {
    authContext.acquireToken(organizationURI, retrieveAccounts)
  }


  function logout(onSuccess, onError) {
    authContext.logOut();
  }

  function authenticate() {
    authContext = new AuthenticationContext(config);

    // Check For & Handle Redirect From AAD After Login
    var isCallback = authContext.isCallback(window.location.hash);
    if (isCallback) {
     authContext.handleWindowCallback();
    }
    var loginError = authContext.getLoginError();

    if (isCallback && !loginError) {
     window.location = authContext._getItem(authContext.CONSTANTS.STORAGE.LOGIN_REQUEST);
//     var token = authContext._getItem(authContext.CONSTANTS.ACCESS_TOKEN);
//     window.location = token;
//     return
    }
    /*else {
     errorMessage.textContent = loginError;
    }*/
//     user = authContext.getCachedUser();
//    if (!user) {
//       authContext.login();
//    }
//    else
//       authContext.acquireTokenPopup(organizationURI);

  }

  function getAccessToken(){
    user = authContext.getCachedUser();
         var token = authContext.getCachedToken(authContext.CONSTANTS.STORAGE.ACCESS_TOKEN_KEY);

    if (!token) {
        authContext.login();
    }
    else
        authContext.acquireTokenPopup(organizationURI);
  }



    //   function getIdToken() {
    //     return authResult ? authResult.idToken : null;
    //   }

  return {
    init: init,
    login: login,
    logout: logout,
    // getIdToken: getIdToken,
    getAccessToken: getAccessToken,
  };
})();

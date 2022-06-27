import 'package:searching_dataverse/src/features/home/search_screen/usecase/get_accounts.dart';

const MOCK_ACCESSTOKEN_TOKEN =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IjJaUXBKM1VwYmpBWVhZR2FYRUpsOGxWMFRPSSIsImtpZCI6IjJaUXBKM1VwYmpBWVhZR2FYRUpsOGxWMFRPSSJ9.eyJhdWQiOiJodHRwczovL29yZzc1YTk0MjM3LmFwaS5jcm00LmR5bmFtaWNzLmNvbS8iLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC9jNWUwMGIxNC0yMmYwLTQyY2EtOGViNS1lMjcxNDcwYWYzZWQvIiwiaWF0IjoxNjU2MTc3OTkzLCJuYmYiOjE2NTYxNzc5OTMsImV4cCI6MTY1NjE4MjIyNywiYWNyIjoiMSIsImFpbyI6IkUyWmdZUGgzaFZYeTZCT1BLYnUydkExVmNINzg5QTIzeVpwR3I3aEFMVldaSUtWbkRYMEEiLCJhbXIiOlsicHdkIl0sImFwcGlkIjoiZmQ5MTkwYTUtODFiMy00ZDg4LWJmNzctMGNkMDhlMGMxNzA1IiwiYXBwaWRhY3IiOiIwIiwiZmFtaWx5X25hbWUiOiJLaGFuIiwiZ2l2ZW5fbmFtZSI6IlNhcmVlciIsImlwYWRkciI6IjEwMy4xNjcuMTU4LjYxIiwibmFtZSI6IlNhcmVlciBLaGFuIiwib2lkIjoiZTNkMjY3NWUtM2NiZC00YjJlLTgwN2EtMDE4YjkxMzQ0M2I5IiwicHVpZCI6IjEwMDMyMDAyMDZDRTVEN0IiLCJyaCI6IjAuQVlJQUZBdmd4ZkFpeWtLT3RlSnhSd3J6N1FjQUFBQUFBQUFBd0FBQUFBQUFBQUNWQU00LiIsInNjcCI6InVzZXJfaW1wZXJzb25hdGlvbiIsInN1YiI6Iml1VEh3OGU0a3pBcHJnUmYxWG5yemx0RTBJdmVPM2ctaFd5aTZvbUJNUTgiLCJ0aWQiOiJjNWUwMGIxNC0yMmYwLTQyY2EtOGViNS1lMjcxNDcwYWYzZWQiLCJ1bmlxdWVfbmFtZSI6InNhcmVlcmtoYW5Ac2FyZWVya2hhbi5vbm1pY3Jvc29mdC5jb20iLCJ1cG4iOiJzYXJlZXJraGFuQHNhcmVlcmtoYW4ub25taWNyb3NvZnQuY29tIiwidXRpIjoiUzNKSkk4UW95RWVwaThUWUd3VlFBQSIsInZlciI6IjEuMCJ9.N3jIofAL36_LN4wcj6C_qSROkafC6GrhRGS7gzHE3tcUQSyYwu6upyGGPLKB3LvXW_pDNN2NpsVjG6JCWzlFaNLlPEuaLIvbNrL1mamb06fg0eStuxlU3yOGUXrY9szvMGXeNH4dr3MSeQV-11kTrB3Trjz2q7I4c5_PwgUnfmRHgxj0EhKpaBigmAJq8cNzAiPUA1vHRYyZO5hHWh0uaePjYQf7uI2xEoYHLACIqK_XjERJRUNaaW46E1mrGWSvEGvulI8na9dmz_DuL_XY6DRmauWHm11C-DgJzSdI0Gbl4wBMY_Aedumb2xzWaW3cezkubkH9ZvG6zSLgjowl1g';

const MOCK_ACCOUNT_ID = '1231-1232-1232-1234';
const MOCK_ACCOUNT_NUMBER = '1234';
const MOCK_EMAIL = 'abc@def.ghi';
const MOCK_ADDRESS = 'bla bla bla';
const MOCK_NAME = 'Jhon';
const MOCK_POST_CODE = '2022';
const MOCK_CITY = 'Raymond';
const MOCK_STATE_PROVINCE = 'WA';
const MOCK_COUNTRY = 'United States';
const MOCK_STATE_CODE = 0;
const MOCK_WEB_API_URL = 'https://org75a123456.api.crm4.dynamics.com/api/data/v9.2';

const MOCK_ACCOUNT_JSON = [
  {
    'accountid': '123',
    'accountnumber': MOCK_ACCOUNT_NUMBER,
    'name': 'markus',
    'emailaddress1': MOCK_EMAIL,
    'address1_composite': MOCK_ADDRESS,
    'address1_postalcode': MOCK_POST_CODE,
    'address1_city': 'New York',
    'address1_stateorprovince': 'NY',
    'address1_country': MOCK_COUNTRY,
    'statecode': MOCK_STATE_CODE
  },
  {
    'accountid': MOCK_ACCOUNT_ID,
    'accountnumber': MOCK_ACCOUNT_NUMBER,
    'name': MOCK_NAME,
    'emailaddress1': MOCK_EMAIL,
    'address1_composite': MOCK_ADDRESS,
    'address1_postalcode': MOCK_POST_CODE,
    'address1_city': MOCK_CITY,
    'address1_stateorprovince': MOCK_STATE_PROVINCE,
    'address1_country': MOCK_COUNTRY,
    'statecode': MOCK_STATE_CODE
  }
];
final MOCK_ACCOUNT_LIST = [
  const Account(
      accountid: '123',
      accountnumber: MOCK_ACCOUNT_NUMBER,
      name: 'markus',
      emailaddress1: MOCK_EMAIL,
      address1_composite: MOCK_ADDRESS,
      address1_postalcode: MOCK_POST_CODE,
      address1_city: 'New York',
      address1_stateorprovince: 'NY',
      address1_country: MOCK_COUNTRY,
      statecode: MOCK_STATE_CODE),
  const Account(
      accountid: MOCK_ACCOUNT_ID,
      accountnumber: MOCK_ACCOUNT_NUMBER,
      name: MOCK_NAME,
      emailaddress1: MOCK_EMAIL,
      address1_composite: MOCK_ADDRESS,
      address1_postalcode: MOCK_POST_CODE,
      address1_city: MOCK_CITY,
      address1_stateorprovince: MOCK_STATE_PROVINCE,
      address1_country: MOCK_COUNTRY,
      statecode: MOCK_STATE_CODE),
];

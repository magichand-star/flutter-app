const kTextValidatorUsernameRegex = r'^[a-zA-Z][a-zA-Z0-9_-]{2,16}$';
const kTextValidatorEmailRegex =
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
const kTextValidatorWebsiteRegex =
    r'(https?:\/\/)?(www\.)[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,10}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)|(https?:\/\/)?(www\.)?(?!ww)[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,10}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)';

const kMonarchiumEmail = 'monarchium.info@gmail.com';

const defaultImg1 =
    'https://firebasestorage.googleapis.com/v0/b/monarchium-5f98b.appspot.com/o/TestsEmblems%2FFrame%203%20(27).png?alt=media&token=a853dd0e-f751-41c4-87cd-0d391c657f8f';
const defaultImg2 =
    'https://firebasestorage.googleapis.com/v0/b/monarchium-5f98b.appspot.com/o/TestsEmblems%2FFrame%204%20(26).png?alt=media&token=493d2fd7-3cac-494c-bc4e-6ae64e7cb29c';

const List<Map<String, dynamic>> statuses = [
  {
    'titleMale': 'Дворянин',
    'titleFemale': 'Дворянка',
    'limitFrom': 5000,
    'limitTo': 15000,
  },
  {
    'titleMale': 'Барон',
    'titleFemale': 'Баронесса',
    'limitFrom': 15000,
    'limitTo': 30000,
  },
  {
    'titleMale': 'Граф',
    'titleFemale': 'Графиня',
    'limitFrom': 30000,
    'limitTo': 50000,
  },
  {
    'titleMale': 'Маркиз',
    'titleFemale': 'Маркиза',
    'limitFrom': 50000,
    'limitTo': 80000,
  },
  {
    'titleMale': 'Князь',
    'titleFemale': 'Княгиня',
    'limitFrom': 80000,
    // 'limitTo': 100000,
  }
];

const String kActivitiesKey = 'activities';
const String kHobbiesKey = 'hobbies';
const String kReferalLink = 'referalLink';

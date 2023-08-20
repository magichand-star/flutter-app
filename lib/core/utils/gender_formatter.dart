enum Gender {
  male,
  female,
}

getGender(String? gender) {
  if (gender == null || gender.isEmpty) return;
  if (gender.toLowerCase() == 'мужской') return Gender.male;
  if (gender.toLowerCase() == 'женский') return Gender.female;
  return;
}

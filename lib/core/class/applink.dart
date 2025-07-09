class Applink {
  static const String loaclhost = 'http://10.0.2.2:8000/api';
  static const String apiSignup = '$loaclhost/register';
  static const String apiLogin = '$loaclhost/login';
  static const String apiUserDetails = '$loaclhost/getprofileuser';
  static const String apiProjetByUser = '$loaclhost/getprojetsbyuser';
  static const String apiTaskByUser = '$loaclhost/getTasksByUser';
  static const String storeProject = '$loaclhost/storeprojet';
  static const String logout = '$loaclhost/logout';
  static const String storeTask = '$loaclhost/storeTask';
  static const String deleteTask = '$loaclhost/deletetask';
  static const String updateTask = '$loaclhost/updatetask';
  static const String updateUser = '$loaclhost/updateUser';
  static const String askgemini = '$loaclhost/ask-gemini-2';
  static const String deleteprojet = '$loaclhost/deleteprojet';
  static const String updateprojet = '$loaclhost/updateprojet';
  static const String meet = '$loaclhost/create-meeting';
  static const String getMeetByUser = '$loaclhost/get-meeting-user';
}

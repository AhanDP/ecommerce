class Commands{

  static String getFirmwareVersion = "f40e01";
  static String getDeviceInfo = "f40e02";
  static String getLockInfo = "f40e07";
  static String syncEvent = "f40e06ff";
  static String eventSyncError = "f40e06fe";
  static String getEvents = "f40e05";
  static String noEvents = "f40e05";
  static String lockOpenSuccess = "f40e07ff";
  static String lockCloseSuccess = "f40e08ff";
  static String invalidPin = "f40e07fe";
  static String tampered = "f40e0700";
  static String lockOpenFailure = "f40e0701";
  static String lockCloseFailure = "f40e0702";
  static String lockOutActivated = "f40e0704";
  static String lockOpen = "f40e07";
  static String lockClose = "f40e08";
  static String syncLock = "f40e0a";
  static String syncLockSuccess = "f40e0aff";
  static String syncLockFailure = "f40e0afe";

  static List<int> refreshData = [0xf4, 0x0e, 0x02];
  static List<int> eventSyncStartData = [0xf4, 0x0e, 0x05, 0x0c];
}
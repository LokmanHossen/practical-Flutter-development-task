class SolarData {
  final double liveAcPower;
  final double plantGeneration;
  final double livePr;
  final double cumulativePr;
  final double returnPv;
  final double totalEnergy;
  final double yesterdayAcMaxPower;
  final double todayAcMaxPower;
  final double yesterdayNetEnergy;
  final double todayNetEnergy;
  final double yesterdaySpecificYield;
  final double todaySpecificYield;
  final int totalPvModules;
  final int pcsPerModule;
  final double totalAcCapacity;
  final double totalDcCapacity;
  final String commissioningDate;
  final int inverterCount;
  final List<InverterData> inverters;

  SolarData({
    required this.liveAcPower,
    required this.plantGeneration,
    required this.livePr,
    required this.cumulativePr,
    required this.returnPv,
    required this.totalEnergy,
    required this.yesterdayAcMaxPower,
    required this.todayAcMaxPower,
    required this.yesterdayNetEnergy,
    required this.todayNetEnergy,
    required this.yesterdaySpecificYield,
    required this.todaySpecificYield,
    required this.totalPvModules,
    required this.pcsPerModule,
    required this.totalAcCapacity,
    required this.totalDcCapacity,
    required this.commissioningDate,
    required this.inverterCount,
    required this.inverters,
  });

  factory SolarData.initial() {
    return SolarData(
      liveAcPower: 0,
      plantGeneration: 0,
      livePr: 0,
      cumulativePr: 0,
      returnPv: 0,
      totalEnergy: 0,
      yesterdayAcMaxPower: 0,
      todayAcMaxPower: 0,
      yesterdayNetEnergy: 0,
      todayNetEnergy: 0,
      yesterdaySpecificYield: 0,
      todaySpecificYield: 0,
      totalPvModules: 0,
      pcsPerModule: 0,
      totalAcCapacity: 0,
      totalDcCapacity: 0,
      commissioningDate: '',
      inverterCount: 0,
      inverters: [],
    );
  }
}

class InverterData {
  final String id;
  final double power;
  final double voltage;
  final double lifetimeEnergy;
  final double prevMeterEnergy;
  final double todayEnergy;
  final double livePower;

  InverterData({
    required this.id,
    required this.power,
    required this.voltage,
    required this.lifetimeEnergy,
    required this.prevMeterEnergy,
    required this.todayEnergy,
    required this.livePower,
  });
}
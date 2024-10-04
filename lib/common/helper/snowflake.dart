class Snowflake {
  static final Snowflake _instance = Snowflake._internal();

  static Snowflake get instance => _instance;

  Snowflake._internal();

  int _sequence = 0;
  final int _epoch = 1609459200000; // 2021-01-01 00:00:00 UTC
  final int _workerId = 1; // 工作机器 ID
  final int _datacenterId = 1; // 数据中心 ID

  int _lastTimestamp = -1;

  int nextId() {
    final int timestamp = _currentTimeMillis();

    if (timestamp < _lastTimestamp) {
      throw Exception("Clock moved backwards. Refusing to generate id");
    }

    if (_lastTimestamp == timestamp) {
      _sequence = (_sequence + 1) & 0xFFF; // 12 bits
    } else {
      _sequence = 0;
    }

    _lastTimestamp = timestamp;

    return ((timestamp - _epoch) << 22) |
        (_datacenterId << 17) |
        (_workerId << 12) |
        _sequence;
  }

  int _currentTimeMillis() {
    return DateTime.now().millisecondsSinceEpoch;
  }
}

void main() {
  final id = Snowflake.instance.nextId(); // 生成一个 ID
  print(id);
}

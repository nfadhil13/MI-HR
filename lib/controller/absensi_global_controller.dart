import 'package:get/get.dart';
import 'package:movie_app/controller/base_controller.dart';
import 'package:movie_app/models/absensi.dart';
import 'package:movie_app/repository/absensi_repository.dart';
import 'package:movie_app/util/single_event.dart';

class AbsensiGlobalController extends BaseController {
  final _absensiRepository = AbsensiRepository();
  final String source;

  AbsensiGlobalController(this.source){
    print("Global controller dibuat dari $source");
  }

  final  absensiList = <Absensi>[].obs;
  final  lastAbsensi =  Rxn<Absensi?>();
  var  _shouldCheckIn = false;
  @override
  void onInit() {
    getAbsensiList();
    super.onInit();
  }

  @override
  void dispose() {
    print("disposing");
    super.dispose();
  }

  bool get shouldCheckIn => _shouldCheckIn;





  Absensi? _getLastAbsensi(List<Absensi> absensiList){
    if(absensiList.isNotEmpty && absensiList.first.checkOut == null){
      _shouldCheckIn = false;
      return absensiList.first;
    }
    _shouldCheckIn = true;
    return null;
  }

  void getAbsensiList() {
    print("get absensi list di $source");
    fetch<List<Absensi>>(() => _absensiRepository.getAbsensiList(), (data) {
      absensiList.addAll(data);
      print("get absensi data di controller");
      print(data);
      final testLastAbsensi = _getLastAbsensi(data);
      lastAbsensi.value = testLastAbsensi;
    }, beforeStart: () {
      absensiList.clear();
    });

  }

}
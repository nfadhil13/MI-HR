import 'package:flutter/material.dart';
import 'package:movie_app/datasource/cache/service/UserDao.dart';
import 'package:movie_app/provider/department_provider.dart';
import 'package:movie_app/screens/department_detail/department_detail_screen.dart';
import 'package:movie_app/screens/department_list/department_list_header_section.dart';
import 'package:movie_app/screens/department_list/department_list_search_section.dart';
import 'package:movie_app/screens/login/login_screen.dart';
import 'package:movie_app/util/color.dart';
import 'package:movie_app/widgets/MainDrawer.dart';
import 'package:movie_app/widgets/department_card.dart';
import 'package:movie_app/widgets/loading_text.dart';
import 'package:provider/provider.dart';

class DepartmentListScreen extends StatefulWidget {
  const DepartmentListScreen({Key? key}) : super(key: key);

  static final routeName = "/department-list-screen";

  @override
  _DepartmentListScreenState createState() => _DepartmentListScreenState();
}

class _DepartmentListScreenState extends State<DepartmentListScreen> {



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<DepartmentProvider>(context, listen: false).getDepartmentList();
    });
  }

  Widget _buildWhenListEmpty() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 30),
          Image.asset("assets/img/empty_list.gif", fit: BoxFit.contain,  width: 150,
              height: 150),
          SizedBox(height: 20),
          Text("No Department found")
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 30),
          Image.asset("assets/img/loading.gif", fit: BoxFit.contain,  width: 150,
            height: 150),
          SizedBox(height: 20),
          LoadingText()
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.primaryThird,
        elevation: 0,
        iconTheme: IconThemeData(
          color: ThemeColors.primaryOne
        ),
      ),
      backgroundColor: ThemeColors.primaryThird,
      body: Padding(
        padding: EdgeInsets.only(left: 18, right: 18, bottom: 18),
        child: RefreshIndicator(
          onRefresh: () async{
            Provider.of<DepartmentProvider>(context, listen: false).getDepartmentList();
          },
          child: CustomScrollView(
            slivers: [
              SliverList(delegate: SliverChildListDelegate.fixed(
                [
                  DepartmentListHeaderSection(),
                  SizedBox(height: 30),
                  DepartmentListSearchSection(),
                  Consumer<DepartmentProvider>(builder: (_, deparment, __) {
                    if(deparment.isFetching){
                      return _buildLoading();
                    }else if(deparment.departmentList.isEmpty && !deparment.isFetching){
                      return _buildWhenListEmpty();
                    };
                    return Container();
                  }),
                  SizedBox(height: 20)
                ]
              )),
              Consumer<DepartmentProvider>(
                builder: (_, department, __) {
                  return SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (ctx, index){
                        return Container(
                            margin: EdgeInsets.only(top: 15),
                            child: DepartmentCard( department.departmentList[index], index, () {
                              Navigator.pushNamed(context, DepartmentDetailScreen.routeName, arguments: department.departmentList[index]);
                            })
                        );
                      },
                        childCount: department.departmentList.length
                  ));
                },
              )
            ],
          ),
        )
      ),
    );
  }


}



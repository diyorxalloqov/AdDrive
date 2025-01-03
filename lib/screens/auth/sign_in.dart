import 'package:addrive/global/imports/app_imports.dart';
import 'package:addrive/screens/auth/sign_up.dart';

class UserSignIn extends StatefulWidget {
  const UserSignIn({super.key});

  @override
  UserSignInState createState() => UserSignInState();
}

class UserSignInState extends State<UserSignIn> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool isLoading = false;
  bool obscureText = true;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInUpController>(
      builder: (signInController) {
        return Scaffold(
          body: signInController.loading.value
              ? const Loading()
              : SafeArea(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 22, right: 22, top: 40),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Image.asset(Assets.logoLauncherIcon,
                                color: CustomColors().mainColor(1),
                                scale: 2.5,
                                alignment: Alignment.center),
                            const SpaceHeight(height: 20),
                            Text('Sign_in'.tr,
                                style: Get.textTheme.labelMedium),
                            const SpaceHeight(height: 20),
                            TextFormFieldWidget(
                              controller: _phoneController,
                              validator: (val) =>
                                  val!.isEmpty ? 'enter_email_please'.tr : null,
                              prefixIconName: Assets.iconsPhone,
                              hintText: 'email_or_phone'.tr,
                              onChanged: (val) {
                                setState(() {
                                  email = val;
                                });
                              },
                            ),
                            const SpaceHeight(height: 20),
                            TextFormFieldWidget(
                              controller: _passwordController,
                              obscureText: obscureText,
                              suffixs: GestureDetector(
                                  onTap: () {
                                    obscureText = !obscureText;
                                    setState(() {});
                                  },
                                  child: Icon(
                                      obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: CustomColors().mainColor(1))),
                              validator: (val) => val!.isEmpty
                                  ? 'enter_password_please'.tr
                                  : null,
                              prefixIconName: Assets.iconsSecurity,
                              hintText: 'password'.tr,
                              onChanged: (val) {
                                setState(() {
                                  password = val;
                                });
                              },
                            ),
                            const SpaceHeight(height: 8.0),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                  onTap: () => Get.to(const ForgetPassScreen()),
                                  child: Text('forgot_password'.tr,
                                      style: context
                                          .theme.textTheme.headlineLarge)),
                            ),
                            const SpaceHeight(height: 30.0),
                            CustomButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    signInController.userLogin(
                                        email: email, password: password);
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                },
                                title: "enter".tr),
                            const SpaceHeight(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height: 1,
                                    width: 10,
                                    color: CustomColors().mainColor(1)),
                                const SpaceWidth(width: 20),
                                Text('or'.tr,
                                    style: context.theme.textTheme.labelMedium
                                        ?.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                const SpaceWidth(width: 20),
                                Container(
                                    height: 1,
                                    width: 10,
                                    color: CustomColors().mainColor(1))
                              ],
                            ),
                            const SpaceHeight(height: 20.0),
                            GestureDetector(
                              onTap: () => googleSignIn(context),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: context.theme.dividerColor
                                          .withOpacity(0.1),
                                      width: 1),
                                ),
                                child:
                                    Image.asset(Assets.imagesGoogle, width: 30),
                              ),
                            ),
                            const SpaceHeight(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'don`t_have_account'.tr,
                                  style: context.theme.textTheme.labelMedium
                                      ?.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                ),
                                TextButton(
                                    onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const UserSignUp())),
                                    child: Text('sign_up'.tr,
                                        style: context
                                            .theme.textTheme.headlineLarge
                                            ?.copyWith(fontSize: 14)))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
// Positioned(
// right: 10,
// top: 10,
// child: OutlinedButton(
// onPressed: () => Get.to(const LanguageScreen()),
// style: OutlinedButton.styleFrom(
// shape: const StadiumBorder()),
// child: Text(
// 'language'.tr,
// style: Get.textTheme.titleMedium!
//     .copyWith(color: const Color(0xFF041E48)),
// )),
// ),

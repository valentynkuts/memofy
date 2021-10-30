import 'package:flutter/material.dart';
import 'package:memofy/presentation/screens/tasks_list/tasks_list_screen.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Login to your account'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            _Form(),
            _Header(),
          ],
        ));
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = const TextStyle(
      fontSize: 16.0,
      color: Colors.black,
    );

    final linkButtonStyle = ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Color(0xff01b4e4)),
      textStyle: MaterialStateProperty.all(
        TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Чтобы пользоваться правкой и возможностями рейтинга TMDb,'
            'а также получить персональные рекомендации, необходимо войти в'
            'свою учётную запись. Если у вас нет учётной записи, её регистрация'
            'является бесплатной и простой. Нажмите здесь, чтобы начать',
            style: textStyle,
          ),
          TextButton(
            onPressed: () {},
            style: linkButtonStyle,
            child: Text('Register'),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'Если Вы зарегистрировались, но не получили письмо для '
            'Sподтверждения, нажмите здесь, чтобы отправить письмо повторно.',
            style: textStyle,
          ),
          TextButton(
            onPressed: () {},
            style: linkButtonStyle,
            child: Text('Verify email'),
          ),
        ],
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final _loginTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  String? errorText;

  void _auth() {
    final login = _loginTextController.text;
    final password = _passwordTextController.text;
    if (login == 'xxxx' && password == 'xxxx') {
      errorText = null;

      //final navigator = Navigator.of(context);
      //navigator.push(MaterialPageRoute(builder: (context) => MainScreen()));

      //Navigator.of(context).pushNamed('/tasks_list');

      Navigator.of(context).pushReplacementNamed(TasksListScreen.id);
    } else {
      errorText = 'Wrong login or password';
    }
    setState(() {});
  }

  void _resetPassword() {
    print('reset password');
  }

  @override
  Widget build(BuildContext context) {
    final textFieldDecoration = const InputDecoration(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      isCollapsed: true,
    );

    final textStyle = const TextStyle(
      fontSize: 16.0,
      color: Color(0xff212529),
    );

    final color = const Color(0xff01b4e4);

    final linkButtonStyle = ButtonStyle(
      foregroundColor: MaterialStateProperty.all(color),
      textStyle: MaterialStateProperty.all(
        TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
    final errorText = this.errorText;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (errorText != null) ...[
            Text(
              errorText,
              style: TextStyle(
                fontSize: 17,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 20),
          ],
          Text(
            'Username',
            style: textStyle,
          ),
          TextField(
            controller: _loginTextController,
            decoration: textFieldDecoration,
          ),
          SizedBox(height: 20),
          Text(
            'Password',
            style: textStyle,
          ),
          TextField(
            controller: _passwordTextController,
            decoration: textFieldDecoration,
            obscureText: true,
          ),
          SizedBox(height: 30),
          Row(
            children: [
              ElevatedButton(
                onPressed: _auth,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(color),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  textStyle: MaterialStateProperty.all(
                    TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8,
                    ),
                  ),
                ),
                child: Text('Login'),
              ),
              SizedBox(width: 30),
              TextButton(
                onPressed: _resetPassword,
                style: linkButtonStyle,
                child: Text('Reset password'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/constants/routes.dart';

class UseTherms extends StatelessWidget {
  const UseTherms({Key? key});

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          Navigator.popAndPushNamed(context, NamedRoute.splash);
          return false;
        },
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 150,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new_outlined),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, NamedRoute.home);
                  },
                ),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    'Termos de Uso',
                    style: AppTextStyles.mediumBoldText20
                        .copyWith(color: AppColors.white),
                  ),
                ),
                backgroundColor: AppColors.green,
                floating: true,
                snap: true,
              ),
              SliverPadding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 30.0,
                  bottom: 10.0,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        " 1. Objeto do aplicativo: o aplicativo de gerenciamento de leitura tem como objetivo fornecer aos usuários uma plataforma para organizar e acompanhar seus hábitos de leitura.\n\n"
                        " 2. Uso do aplicativo: o aplicativo é gratuito para uso pessoal. Os usuários podem criar uma conta, adicionar livros à sua lista de leitura, salvar seu progresso de leitura e avaliar os livros.\n\n"
                        " 3. Responsabilidades do usuário: o usuário é responsável por manter suas informações de conta atualizadas e proteger sua senha de acesso. O usuário também concorda em não violar os direitos autorais dos livros ou conteúdos adicionados ao aplicativo.\n\n"
                        " 4. Privacidade e segurança: o aplicativo respeita a privacidade dos usuários e não compartilha informações pessoais com terceiros. O aplicativo também utiliza medidas de segurança para proteger as informações dos usuários.\n\n"
                        " 5. Disponibilidade e interrupções: o aplicativo se esforça para manter a disponibilidade contínua, mas não é responsável por interrupções causadas por problemas técnicos ou de manutenção.\n\n"
                        " 6. Propriedade intelectual: todo o conteúdo do aplicativo, incluindo a marca, logotipo e design, são propriedade exclusiva do desenvolvedor do aplicativo.\n\n"
                        " 7. Cancelamento da conta: o usuário pode cancelar sua conta a qualquer momento, e todas as informações e dados associados serão excluídos do sistema.\n\n"
                        " 8. Alterações nos termos de uso: o desenvolvedor do aplicativo pode alterar os termos de uso a qualquer momento, e os usuários serão notificados sobre quaisquer alterações relevantes.\n\n"
                        " 9. Rescisão do acesso: o desenvolvedor do aplicativo reserva-se o direito de rescindir o acesso de qualquer usuário que viole os termos de uso ou cause problemas ao sistema.\n\n"
                        " 10. Lei aplicável: estes termos de uso serão regidos e interpretados de acordo com as leis do país onde o desenvolvedor do aplicativo está localizado.",
                        textAlign: TextAlign.justify,
                        style: AppTextStyles.smallText,
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      );
}

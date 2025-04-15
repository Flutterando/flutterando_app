import 'package:flutter/material.dart';

import '../../design_system/constants/spaces.dart';
import '../../design_system/theme/theme.dart';
import '../../design_system/widgets/button_widget.dart';
import '../../design_system/widgets/input_widget.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        leading: Icon(
          Icons.cancel_outlined,
          color: Theme.of(context).colors.greyThree,
        ),
        title: Text(
          'Nova Publicaçao',
          style: Theme.of(context).textStyles.bodyXL18Bold.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Spaces.l),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: Spaces.m,
            children: [
              Text(
                '>_',
                style: Theme.of(context).textStyles.bodyM14Bold.copyWith(
                  color: Theme.of(context).colors.greyThree,
                ),
              ),

              Expanded(
                child: Form(
                  child: Column(
                    spacing: Spaces.l,
                    children: [
                      const InputWidget(
                        label: 'Publicação',
                        hintText: 'Digite a sua publicação',
                      ),
                      const InputWidget(
                        label: 'Link da imagem',
                        hintText: 'Ex: https://flutterando.com/exemplo',
                      ),
                      const InputWidget(
                        label: 'Legenda da Imagem',
                        hintText: 'Informe uma descrição',
                      ),
                      const InputWidget(
                        label: 'Legenda da Imagem',
                        hintText: 'Informe uma descrição',
                      ),
                      const InputWidget(
                        label: 'Link da ação',
                        hintText: 'Ex: https://flutterando.com/exemplo',
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FractionallySizedBox(
                          widthFactor: 0.7,
                          child: ButtonWidget.filledPrimary(
                            disabled: true,
                            text: 'Publicar',
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

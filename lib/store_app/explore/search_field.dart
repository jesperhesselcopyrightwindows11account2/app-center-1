import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software/l10n/l10n.dart';
import 'package:software/store_app/common/snap_section.dart';
import 'package:software/store_app/explore/explore_model.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class SearchField extends StatefulWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ExploreModel>();
    return TextField(
      controller: _controller,
      onChanged: (value) => model.searchQuery = value,
      autofocus: true,
      decoration: InputDecoration(
        hintText: context.l10n.searchHint,
        suffixIcon: DropdownButton<SnapSection>(
          underline: const SizedBox(),
          value: model.selectedSection,
          borderRadius: BorderRadius.circular(10),
          elevation: 2,
          items: [
            for (final section in SnapSection.values)
              DropdownMenuItem(
                value: section,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(
                      snapSectionToIcon[section],
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.8),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(section.localize(context.l10n))
                  ],
                ),
              )
          ],
          onChanged: (v) {
            model.selectedSection = v!;
            model.loadSection(v);
          },
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 20),
        prefixIcon: model.searchQuery == ''
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(left: 5),
                child: YaruRoundIconButton(
                  size: 36,
                  onTap: () {
                    model.searchQuery = '';
                    _controller.text = '';
                  },
                  child: const Icon(YaruIcons.edit_clear),
                ),
              ),
        isDense: false,
        border: const UnderlineInputBorder(),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:getshap/common/ui/app_dialog.dart';
import 'package:getshap/l10n/app_localizations.dart';
import 'package:getshap/theme/app_colors.dart';
import 'package:getshap/theme/app_spacing.dart';
import 'package:getshap/theme/app_typography.dart';

/// The menu row for switching between home and park, with the current choice
/// under it. It shows up once the home-or-park question is answered, or has
/// been skipped for the user (see placeQuestionDue in workout_place_page.dart).
///
/// It reads the choice itself, so the side menu can stay stateless, and reads
/// it again after the switch, while the drawer is still open.
class WorkoutPlaceTile extends StatefulWidget {
    const WorkoutPlaceTile({super.key});

    @override
    State<WorkoutPlaceTile> createState() => _WorkoutPlaceTileState();
}

class _WorkoutPlaceTileState extends State<WorkoutPlaceTile> {
    bool _answered = false;
    int _place = 0;

    @override
    void initState() {
        super.initState();
        _load();
    }

    Future<void> _load() async {
        final prefs = await SharedPreferences.getInstance();
        if (!mounted) return;
        setState(() {
            _answered = prefs.getBool('placeQuestionAnswered') ?? false;
            _place = prefs.getInt('placeSwitch') ?? 0;
        });
    }

    /// The two places to pick from: a switch suits one on/off setting, not
    /// picking one of two. Nothing changes until Save: Cancel or a tap beside
    /// the window leaves the choice as it was.
    Future<void> _open() async {
        final AppLocalizations loc = AppLocalizations.of(context)!;
        int place = _place;
        final bool? save = await showDialog<bool>(
            context: context,
            builder: (BuildContext context) => StatefulBuilder(
                builder: (BuildContext context, StateSetter setDialogState) => AppDialog(
                    icon: Icons.place_outlined,
                    title: loc.workoutPlace,
                    content: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                            _PlaceOption(
                                icon: Icons.home_outlined,
                                label: loc.atHome,
                                selected: place == 0,
                                onTap: () => setDialogState(() => place = 0),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            _PlaceOption(
                                icon: Icons.park_outlined,
                                label: loc.inPark,
                                selected: place == 1,
                                onTap: () => setDialogState(() => place = 1),
                            ),
                        ],
                    ),
                    primaryLabel: loc.save,
                    onPrimary: () => Navigator.of(context).pop(true),
                    secondaryLabel: loc.cancel,
                    onSecondary: () => Navigator.of(context).pop(false),
                ),
            ),
        );
        if (save != true) return;

        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('placeSwitch', place);
        await _load();
    }

    @override
    Widget build(BuildContext context) {
        if (!_answered) return const SizedBox.shrink();

        final loc = AppLocalizations.of(context)!;
        return ListTile(
            leading: const Icon(Icons.park_outlined),
            title: Text(loc.workoutPlace),
            subtitle: Text(_place == 1 ? loc.inPark : loc.atHome),
            onTap: _open,
        );
    }
}

/// One of the two places in the window: an icon, the name, and a ring that
/// fills in when it is the chosen one. Tinted rather than filled when
/// selected, so it does not read as a second Save button under it.
class _PlaceOption extends StatelessWidget {
    final IconData icon;
    final String label;
    final bool selected;
    final VoidCallback onTap;

    const _PlaceOption({
        required this.icon,
        required this.label,
        required this.selected,
        required this.onTap,
    });

    @override
    Widget build(BuildContext context) {
        return Semantics(
            button: true,
            selected: selected,
            inMutuallyExclusiveGroup: true,
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                    onTap: onTap,
                    borderRadius: AppRadius.all(AppRadius.md),
                    child: AnimatedContainer(
                        duration: const Duration(milliseconds: 120),
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg,
                            vertical: AppSpacing.md,
                        ),
                        decoration: BoxDecoration(
                            color: selected ? AppColors.brand50 : AppColors.surface,
                            borderRadius: AppRadius.all(AppRadius.md),
                            border: Border.all(
                                color: selected ? AppColors.brand500 : AppColors.n200,
                                width: 1.5,
                            ),
                        ),
                        child: Row(
                            children: <Widget>[
                                Icon(icon, color: selected ? AppColors.brand500 : AppColors.n600),
                                const SizedBox(width: AppSpacing.md),
                                Expanded(
                                    child: Text(
                                        label,
                                        style: AppText.titleMedium.copyWith(color: AppColors.n900),
                                    ),
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                Icon(
                                    selected
                                        ? Icons.radio_button_checked_rounded
                                        : Icons.radio_button_unchecked_rounded,
                                    color: selected ? AppColors.brand500 : AppColors.n300,
                                ),
                            ],
                        ),
                    ),
                ),
            ),
        );
    }
}

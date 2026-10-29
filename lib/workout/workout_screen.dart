import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show SliverConstraints;
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import 'package:getshap/common/ui/app_button.dart';
import 'package:getshap/common/ui/app_dialog.dart';
import 'package:getshap/common/ui/app_scaffold.dart';
import 'package:getshap/common/ui/app_step_progress.dart';
import 'package:getshap/l10n/app_localizations.dart';
import 'package:getshap/theme/app_colors.dart';
import 'package:getshap/theme/app_spacing.dart';
import 'package:getshap/theme/app_typography.dart';

class WorkoutScreen extends StatefulWidget {
    final String videoPath;
    final String exerciseName;

    /// The count on its own, e.g. "13". Split from [repsLabel] so the number
    /// can be set at display size — mid-set it has to be readable at a glance,
    /// from the floor, upside down.
    final String reps;

    /// The localised word after it, e.g. "ismétlés".
    final String repsLabel;

    final String description;
    final String buttonText;
    final String label;
    final VoidCallback onNextPressed;
    final VoidCallback onPreviousPressed;
    final int currentIndex;
    final int totalWorkouts;
    final int level;

    /// Set on a test exercise (the park pull test). The screen then asks how
    /// many reps the user managed instead of showing a target, and Save hands
    /// that number here before it calls [onNextPressed].
    final ValueChanged<int>? onTestRepsEntered;

    /// The result already saved on this test. Stepping back to it shows the
    /// number, locked.
    final int? testReps;

    const WorkoutScreen({
        super.key,
        required this.videoPath,
        required this.exerciseName,
        required this.reps,
        required this.repsLabel,
        required this.description,
        required this.buttonText,
        required this.label,
        required this.onNextPressed,
        required this.onPreviousPressed,
        required this.currentIndex,
        required this.totalWorkouts,
        required this.level,
        this.onTestRepsEntered,
        this.testReps,
    });

    @override
    State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
    late VideoPlayerController _controller;
    double _videoAspectRatio = 16 / 9;

    /// Owned explicitly so the scrollbar can attach to it, and so the next
    /// exercise starts at the top of its description rather than wherever the
    /// last one was left scrolled to.
    final ScrollController _descriptionScroll = ScrollController();

    /// The whole page, when it does not fit the screen. The next exercise
    /// starts at its top again.
    final ScrollController _pageScroll = ScrollController();

    /// The number typed on a test.
    final TextEditingController _testReps = TextEditingController();

    bool get _isTest => widget.onTestRepsEntered != null;

    /// A test whose number is still to be entered. A saved one is locked.
    bool get _isEntering => _isTest && widget.testReps == null;

    @override
    void initState() {
        super.initState();
        _testReps.text = widget.testReps?.toString() ?? '';
        _initializeVideo();
    }

    void _initializeVideo() {
        // Capture the controller locally so the initialize callback always acts
        // on this exact instance, never on one that was later replaced/disposed.
        final controller = VideoPlayerController.asset(widget.videoPath);
        _controller = controller;

        controller.initialize().then((_) {
            if (!mounted || controller != _controller) return;
            setState(() {
                _videoAspectRatio = controller.value.aspectRatio;
            });
            controller.setLooping(true);
            controller.setVolume(0.0);
            controller.play();
        });
    }

    void _disposeController() {
        _controller.dispose();
    }

    @override
    void didUpdateWidget(WorkoutScreen oldWidget) {
        super.didUpdateWidget(oldWidget);
        if (oldWidget.videoPath != widget.videoPath) {
            _disposeController();
            _initializeVideo();
        }
        if (oldWidget.description != widget.description &&
            _descriptionScroll.hasClients) {
            _descriptionScroll.jumpTo(0);
        }
        // Another exercise: the number it had, if it is a test the user is
        // coming back to.
        if (oldWidget.currentIndex != widget.currentIndex) {
            _testReps.text = widget.testReps?.toString() ?? '';
            if (_pageScroll.hasClients) _pageScroll.jumpTo(0);
        }
    }

    @override
    void dispose() {
        _testReps.dispose();
        _pageScroll.dispose();
        _descriptionScroll.dispose();
        _disposeController();
        super.dispose();
    }

    /// True once there is somewhere to step back to: an earlier exercise, or
    /// the warm-up that preceded the workout at level 130 and above.
    bool _canGoBack(AppLocalizations loc) =>
        widget.currentIndex > 0 ||
        (widget.label == loc.workout && widget.level >= 130);

    @override
    Widget build(BuildContext context) {
        final AppLocalizations loc = AppLocalizations.of(context)!;
        final bool canGoBack = _canGoBack(loc);

        return AppScaffold(
            title: '${widget.label} (${widget.currentIndex + 1}/${widget.totalWorkouts})',
            leading: IconButton(
                icon: const Icon(Icons.close),
                // Pop back to the live home page rather than building a second
                // one. Both exits from a workout now take the same route (the
                // congratulations screen already does this), and the existing
                // home keeps its WorkoutSignal.onSignalChanged registration — a
                // fresh MyHomePage would claim that single static slot in
                // initState only for the old page's dispose to null it again
                // immediately afterwards, silently killing the home screen's
                // streak/flame refresh for the rest of the session. The workout
                // route is removed either way, so back still cannot return to it.
                onPressed: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
            ),
            bottomBar: Row(
                children: <Widget>[
                    if (canGoBack) ...<Widget>[
                        AppButton.icon(
                            icon: Icons.arrow_back_rounded,
                            label: loc.goback,
                            onPressed: widget.onPreviousPressed,
                        ),
                        const SizedBox(width: AppSpacing.md),
                    ],
                    Expanded(
                        // A test is saved with this button, and cannot go on
                        // until it has a number.
                        child: ValueListenableBuilder<TextEditingValue>(
                            valueListenable: _testReps,
                            builder: (context, value, _) => AppButton(
                                label: _isEntering ? loc.save : widget.buttonText,
                                size: AppButtonSize.md,
                                trailingIcon: Icons.arrow_forward_rounded,
                                onPressed: _isEntering && value.text.isEmpty ? null : _next,
                            ),
                        ),
                    ),
                ],
            ),
            // The description takes what the top of the page leaves, and
            // scrolls there on its own. When the top does not fit at all (a
            // large system font, or the keyboard up on a test), the whole page
            // scrolls instead, with the description after it in full.
            body: CustomScrollView(
                controller: _pageScroll,
                slivers: <Widget>[
                    SliverToBoxAdapter(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                                ..._buildHeader(),
                                if (_isTest) _buildTestReps(loc) else _buildReps(),
                                const SizedBox(height: AppSpacing.lg),
                            ],
                        ),
                    ),
                    SliverLayoutBuilder(
                        builder: (BuildContext context, SliverConstraints constraints) {
                            // Rounded down: a fraction of a pixel too much would
                            // make a page that fits scrollable.
                            final double left = (constraints.viewportMainAxisExtent -
                                    constraints.precedingScrollExtent -
                                    AppSpacing.md)
                                .floorToDouble();
                            final Widget description = Text(
                                widget.description,
                                style: AppText.bodyMedium.copyWith(color: AppColors.n600),
                            );
                            return SliverPadding(
                                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                                sliver: SliverToBoxAdapter(
                                    child: left < 0
                                        ? description
                                        // Plain text on the page rather than the old
                                        // filled panel, which made the instructions
                                        // outweigh the video — the wrong way round
                                        // for something you glance at between reps.
                                        //
                                        // The scrollbar stays, because a description
                                        // that runs past the fold with no mark on it
                                        // looks finished. `thumbVisibility` keeps it
                                        // up the whole time instead of fading after a
                                        // scroll, and Flutter paints nothing at all
                                        // when the text already fits — so it appears
                                        // exactly when it means something.
                                        : SizedBox(
                                            height: left,
                                            child: Scrollbar(
                                                controller: _descriptionScroll,
                                                thumbVisibility: true,
                                                child: SingleChildScrollView(
                                                    controller: _descriptionScroll,
                                                    padding: const EdgeInsets.only(right: AppSpacing.md),
                                                    child: description,
                                                ),
                                            ),
                                        ),
                                ),
                            );
                        },
                    ),
                ],
            ),
        );
    }

    /// On a test still to be entered, Save first asks whether the number is
    /// right, then hands it over: once saved, it cannot change.
    Future<void> _next() async {
        if (_isEntering) {
            // The field itself lets go of the focus. Unfocusing the page's
            // scope instead left the field as the page's last focus, and
            // closing the window handed it back: the keyboard came up again,
            // and on Yes went straight back down as the next exercise came,
            // which on Android can leave the keyboard's height behind as an
            // empty band.
            FocusManager.instance.primaryFocus?.unfocus();
            final int reps = int.parse(_testReps.text);
            final AppLocalizations loc = AppLocalizations.of(context)!;
            final bool? sure = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) => AppDialog(
                    icon: Icons.task_alt_rounded,
                    title: loc.saveConfirm(reps),
                    primaryLabel: loc.yes,
                    onPrimary: () => Navigator.of(context).pop(true),
                    secondaryLabel: loc.no,
                    onSecondary: () => Navigator.of(context).pop(false),
                ),
            );
            if (sure != true || !mounted) return;
            widget.onTestRepsEntered!(reps);
        }
        widget.onNextPressed();
    }

    /// The top of the page, the same for an exercise and a test.
    List<Widget> _buildHeader() {
        return <Widget>[
            const SizedBox(height: AppSpacing.md),
            AppStepProgress(
                total: widget.totalWorkouts,
                completed: widget.currentIndex + 1,
            ),
            const SizedBox(height: AppSpacing.xl),
            _buildVideo(context),
            const SizedBox(height: AppSpacing.xxl),
            // Left-aligned: centred, a heading reads as a poster
            // caption. This is the name of the thing you are doing.
            Text(
                widget.exerciseName,
                style: AppText.headlineMedium.copyWith(color: AppColors.n900),
            ),
            const SizedBox(height: AppSpacing.md),
        ];
    }

    /// On a test, in place of the rep count: what to do, then the field for
    /// how many it was. Once saved, the field keeps the number but is locked
    /// and greyed out.
    /// The label moves under the field when a large system font leaves no
    /// room beside it.
    Widget _buildTestReps(AppLocalizations loc) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
                Text(
                    loc.testRepsHint,
                    style: AppText.bodyMedium.copyWith(color: AppColors.n600),
                ),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: AppSpacing.md,
                    runSpacing: AppSpacing.sm,
                    children: <Widget>[
                        SizedBox(
                            // Three digits at display size, at any font scale.
                            width: MediaQuery.textScalerOf(context).scale(128),
                            child: TextField(
                                controller: _testReps,
                                enabled: _isEntering,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(3),
                                ],
                                textAlign: TextAlign.center,
                                style: AppText.numeral(AppText.displaySmall).copyWith(
                                    color: _isEntering ? AppColors.brand500 : AppColors.n400,
                                ),
                                decoration: const InputDecoration(isDense: true),
                            ),
                        ),
                        Text(
                            widget.repsLabel,
                            style: AppText.titleSmall.copyWith(color: AppColors.n500),
                        ),
                    ],
                ),
            ],
        );
    }

    Widget _buildVideo(BuildContext context) {
        return Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.3,
            ),
            alignment: Alignment.center,
            child: AspectRatio(
                aspectRatio: _videoAspectRatio,
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: AppColors.videoBackdrop,
                        borderRadius: AppRadius.all(AppRadius.md),
                        boxShadow: AppShadows.md,
                    ),
                    child: ClipRRect(
                        borderRadius: AppRadius.all(AppRadius.md),
                        child: _controller.value.isInitialized
                            ? VideoPlayer(_controller)
                            : const Center(child: CircularProgressIndicator()),
                    ),
                ),
            ),
        );
    }

    /// The rep count as a number, not a label.
    ///
    /// It used to be an 18px pill reading "13 Ismétlés" — the same weight as
    /// the metadata around it, for the single figure the screen exists to
    /// convey. At display size the number is legible across the room; the word
    /// beside it stays small because it never changes.
    ///
    /// It grows with the system font only until it is as wide as the screen:
    /// at 1.3x "10-15 Wiederholungen" ran off the edge. Up to that width it is
    /// drawn exactly as before, and past it the whole line shrinks to fit,
    /// never below its size at a normal font.
    Widget _buildReps() {
        return Align(
            alignment: Alignment.centerLeft,
            child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                        Text(
                            widget.reps,
                            style: AppText.numeral(AppText.displaySmall).copyWith(
                                color: AppColors.brand500,
                            ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                            widget.repsLabel,
                            style: AppText.titleSmall.copyWith(color: AppColors.n500),
                        ),
                    ],
                ),
            ),
        );
    }
}

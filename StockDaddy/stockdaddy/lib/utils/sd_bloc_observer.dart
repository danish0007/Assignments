import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';

/// {@template sd.cms.bloc.observer}
/// bloc observer logs all state changes of every bloc
/// {@endtemplate}
class SDBlocObserver extends BlocObserver {
  final _log = Logger('[SDBlocObserver] =====>> ');
  @override
  void onEvent(Bloc bloc, Object? event) {
    _log.info('Bloc event >> $bloc\n $event');
    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _log.shout('ERROR encountered in $bloc', error, stackTrace);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    _log.info('Bloc change >> $bloc\n $change');
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    _log.info('Bloc state transition >> $bloc\n $transition');
    super.onTransition(bloc, transition);
  }
}

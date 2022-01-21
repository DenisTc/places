import 'package:flutter/material.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/location.dart';
import 'package:places/ui/res/icons.dart';

// String constants
const String textToFavorite = 'В избранное';
const String textInFavorite = 'В избранном';
const String textFavorite = 'Избранное';
const String textBtnSchedule = 'Запланировать';
const String textBtnRoute = 'ПОСТРОИТЬ МАРШРУТ';
const String textGallery = 'ГАЛЕРЕЯ';
const String textCategory = 'Категория';
const String textTitle = 'НАЗВАНИЕ';
const String textDescription = 'ОПИСАНИЕ';
const String textBtnShowOnMap = 'Указать на карте';
const String textLatitude = 'ШИРОТА';
const String textEnterLatitude = 'Введите значение широты';
const String textLongitude = 'ДОЛГОТА';
const String textEnterLongitude = 'Введите значение долготы';
const String textBtnCreate = 'СОЗДАТЬ';
const String textBtnClear = 'Очистить';
const String textCategories = 'КАТЕГОРИИ';
const String textDistance = 'Расстояние';
const String textBtnShow = 'ПОКАЗАТЬ';
const String textDarkTheme = 'Тёмная тема';
const String textBtnTutorial = 'Смотреть туториал';
const String textSettings = 'Настройки';
const String textBtnSave = 'СОХРАНИТЬ';
const String textError = 'Ошибка';
const String textTryLater = 'Что то пошло не так\nПопробуйте позже.';
const String textHistory = 'ВЫ ИСКАЛИ';
const String textBtnClearHistory = 'Очистить историю';
const String textNewPlace = 'Новое место';
const String textCancel = 'Отмена';
const String textBtnCamera = 'Камера';
const String textBtnPhoto = 'Фотография';
const String textBtnFile = 'Файл';
const String textListPlaces = 'Список интересных мест';
const String textBigListPlaces = 'Список\nинтересных мест';
const String textBtnStart = 'НА СТАРТ';
const String textBtnSkip = 'Пропустить';
const String textNotFound = 'Ничего не найдено.';
const String textTryChangeOptions = 'Попробуйте изменить параметры\nпоиска';
const String textBtnDelete = 'Удалить';
const String textScrWantToVisit = 'Отмечайте понравившиеся\nместа и они появятся здесь.';
const String textScrVisited = 'Завершите маршрут,\nчтобы место попало сюда.';
const String textAddNewPlaceSuccess = 'Место успешно добавлено!';
const String textBtnBackToMainScreen = 'Вернуться на главный экран';
const String textAddNewPlaceError = 'При добавлении нового места возникла ошибка. Попробуйте добавить новое место позже.';
const String textAddNewPlaceInProcess = 'Подождите, добавляем место...';
const String textSelectCategory = 'Выберите категорию';
const String textNotSelected = 'Не выбрано';
const String textEnterNamePlace = 'Введите название места';
const String textEnterDescPlace = 'Заполните описание';
const String textEnterText = 'введите текст';
const String textOnboardingScreenFirstTitle = 'Добро пожаловать\nв Путеводитель';
const String textOnboardingScreenFirstDesc = 'Ищи новые локации и сохраняй\nсамые любимые.';
const String textOnboardingScreenSecondTitle = 'Построй маршрут\nи отправляйся в путь';
const String textOnboardingScreenSecondDesc = 'Достигай цели максимально\nбыстро и комфортно.';
const String textOnboardingScreenThirdTitle = 'Добавляй места,\nкоторые нашёл сам';
const String textOnboardingScreenThirdDesc = 'Делись самыми интересными\nи помоги нам стать лучше!';
const String textFavoriteTab = 'Хочу посетить';
const String textVisitedTab = 'Посетил';
const String textScheduledFor = 'Запланировано на';
const String textTheGoalIsAchieved = 'Цель достигнута';
const String textIsEmpty = 'Пусто';
const String textShare = 'Поделиться';
const String textPassed = 'ПРОЙДЕНО';
const String textMap = 'Карта';

// Images
const String pathLoader = 'res/images/loader.png';
const String pathIconLightDotMap = 'res/images/map/light_dot.png';
const String pathIconDarkDotMap = 'res/images/map/dark_dot.png';
const String pathIconSelectedPlaceMap = 'res/images/map/selected_place.png';
const String pathIconUserMap = 'res/images/map/user.png';

// Location
const Location userLocation = Location(lat: 57.81929846395932, lng: 28.332799972367415); // [57,81929846395932,28,332799972367415] 57.817029184, lng: 28.339347297

// For FiltersScreen
const RangeValues defaultDistanceRange = RangeValues(0, 10000.0);
const List<Category> categories = [
    Category(type: 'other', name: 'прочее', icon: iconParticularPlace),
    Category(type: 'monument', name: 'памятник', icon: iconParticularPlace),
    Category(type: 'park', name: 'парк', icon: iconPark),
    Category(type: 'hotel', name: 'отель', icon: iconHotel),
    Category(type: 'museum', name: 'музей', icon: iconMuseum),
    Category(type: 'theatre', name: 'театр', icon: iconParticularPlace),
    Category(type: 'cafe', name: 'кафе', icon: iconCafe),
    Category(type: 'temple', name: 'храм', icon: iconParticularPlace),
    Category(type: 'restaurant', name: 'ресторан', icon: iconRestourant),
  ];

// For SearchFilter
const List<String> selectedCategories = ['monument', 'other', 'theatre'];

// Key for Shared preferences plugin
const String keySPFilter = 'SearchFilter';
const String keySPTheme = 'Theme';
const String keySPOnboarding = 'Onboarding';

// Yandex map styles
const String lightStyleYandexMap = '''
      [
        {
          "stylers": {
            "saturation": -1,
            "lightness": 0.1
          }
        }
      ]
    ''';
const String darkStyleYandexMap = '''
    [
        {
          "stylers": {
            "hue": "202031",
            "saturation": 0,
            "lightness": 0
          }
        },
        {
          "tags": {
            "all": ["road"]
          },
          "stylers": {
            "color": "3b3e5b",
            "saturation": 0.5,
            "lightness": 0
          }
        },
        {
          "tags": {
            "all": ["transit"]
          },
          "stylers": {
            "color": "3b3e5b",
            "saturation": 0.5,
            "lightness": 0
          }
        },
        {
          "tags": {
            "all": ["water"]
          },
          "stylers": {
            "color": "2d2c45",
            "lightness": 0
          }
        }
      ]
      ''';
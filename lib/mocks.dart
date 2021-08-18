import 'package:places/domains/sight.dart';
import 'package:places/ui/icons.dart';

final List<Sight> mocks = [
  const Sight(
    'Свято-Троицкий собор (Псков)',
    57.82210891005884,
    28.32903412826858,
    ['https://putidorogi-nn.ru/images/stories/evropa/rossiya/troickiy_sobor_v_pskove_4.jpg'],
    'Свято-Троицкий собор - православный храм во Пскове, кафедральный собор Псковской епархии. Входит в состав архитектурного ансамбля Псковского крома и является главным его строением.',
    'Особое место',
    null //iconParticularPlace,
  ),
  const Sight(
    'Финский парк (Парк Куопио)',
    57.82220455285637,
    28.348753780017827,
    ['https://allmyworld.ru/wp-content/uploads/2021/06/dostoprimechatelnosti-pskova-Finskij-park-Kuopio.jpg'],
    'Финский парк расположен в центральной части города, на левом берегу реки Псковы, от пешеходного до Кузнецкого моста.Парк для прогулок в долине реки Псковы был заложен в начале 1990-х годов по проекту архитекторов из финского города-побратима Куопио.',
    'Парк',
    iconPark,
  ),
  const Sight(
    'Old Estate Hotel & SPA',
    57.82312741707346,
    28.339902561948225,
    ['https://cf.bstatic.com/xdata/images/hotel/max1024x768/6864006.jpg?k=48875e6401c714da45566bdb7f7214313d467f259fb8b946af6dc4bf69701a11&o=&hp=1'],
    'Идеальный отель для бизнеса и отдыха: высококлассный сервис, респектабельные интерьеры, 50 номеров повышенной комфортности... Является современной реконструкцией памятников архитектуры XVII-XIX веков. В трех минутах от исторического центра города.',
    'Отель',
    iconHotel,
  ),
  const Sight(
    'Михайловское',
    57.06104067105939,
    28.919454220496746,
    ['https://tur-mobile.ru/wp-content/uploads/2020/10/pushkinskie-gory.-2.jpg', 'https://cdn21.img.ria.ru/images/59598/22/595982261_0:0:0:0_600x0_80_0_0_b80572b2857d0dd6e6d1ae7bfea1a9d2.jpg','https://www.advantour.com/russia/images/pskov/pskov-mikhaylovskoye.jpg','https://putidorogi-nn.ru/images/stories/evropa/usadba_mihaylovskoe_v_pskovskoy_oblasti_7.jpg'],
    '«Миха́йловское» — действующий музей-заповедник Александра Сергеевича Пушкина в Пушкиногорском районе Псковской области Российской Федерации, основанный в 1922 году. Является объектом культурного наследия федерального значения.',
    'Музей',
    iconMuseum,
  ),
  const Sight(
    'Ресторан HELGA',
    57.82090523332626,
    28.320911696511036,
    ['https://borisstars.ru/img/upload/summer/11535/DSC02400_1561905293.JPG'],
    'Средневековый ресторан «Helga» расположился в районе ближнего Завеличья, и предлагает гостям большой выбор русских и европейских блюд, приготовленных на средневековый манер.',
    'Ресторан',
    iconCafe,
  ),
];

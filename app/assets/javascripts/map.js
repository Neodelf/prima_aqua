ymaps.ready(init);
function init () {
    var myMap = new ymaps.Map('contacts_map', {
            center: [59.937886, 30.344604],
            zoom: 17
        }),
        markRudneva = new ymaps.Placemark([60.048392, 30.367005], {
            hintContent: 'ул. Руднева, д.22/1 <br/> (812) 517-83-84'
        }, {
            // Опции.
            // Необходимо указать данный тип макета.
            iconLayout: 'default#image',
            // Своё изображение иконки метки.
            iconImageHref: '/assets/prod.png',
            // Размеры метки.
            iconImageSize: [30, 42],
            // Смещение левого верхнего угла иконки относительно
            // её "ножки" (точки привязки).
            iconImageOffset: [-3, -42]
        }),
        markBelinskogo = new ymaps.Placemark([59.937886, 30.344604], {
            hintContent: "ул. Белинского, д.1 <br/>(812) 272-55-84"
        }, {
            // Опции.
            // Необходимо указать данный тип макета.
            iconLayout: 'default#image',
            // Своё изображение иконки метки.
            iconImageHref: '/assets/office.png',
            // Размеры метки.
            iconImageSize: [30, 42],
            // Смещение левого верхнего угла иконки относительно
            // её "ножки" (точки привязки).
            iconImageOffset: [-3, -42]
        });

    myMap.geoObjects.add(markRudneva);
    myMap.geoObjects.add(markBelinskogo);
    myMap.controls.add("zoomControl");
}

﻿////////////////////////////////////////////////////////////////////////////////
// Процедуры и функции справочника Проекты, доступные для нескольких формы, в частности:
// 
//
////////////////////////////////////////////////////////////////////////////////

#Область РаботаСДеталями

Процедура ПриИзмененииДеталиНаСервере(Форма, ИдСтроки) Экспорт
	
	Объект = Форма.Объект;
	
	ТекСтрока = Объект.Детали.НайтиПоИдентификатору(ИдСТроки);
	
	ХарактеристикиДетали = Справочники.ДеталиПроекта.ЗапроситьПараметрыДетали(
		ОбщегоНазначения.ЗначениеВМассив(ТекСтрока.ДетальПроекта));
	
	ГраницаХарактеристик = Макс(Мин(
		ФормыПроектыКлиентСервер.ЛимитХарактеристик(), 
		ХарактеристикиДетали.Количество()), 
		ФормыПроектыКлиентСервер.ЛимитХарактеристик()
	);
	
	Для ИдКолонки = 1 По ГраницаХарактеристик Цикл
		
		НайтиДобавитьЭлементыСтрокиДеталей(Форма, ИдКолонки);
		
	КонецЦикла;
	
	// Проставляем данные из БД
	ЗаполнитьХарактеристикиДетали(Форма, ИдСтроки, ХарактеристикиДетали);
	
	РасссчитатьЗначенияФормул(Форма, ИдСтроки);
	
КонецПроцедуры

Процедура ЗаполнитьХарактеристикиДетали(Форма, ИдСтроки, ХарактеристикиДетали) Экспорт
	
	Объект = Форма.Объект;
	Элементы = Форма.Элементы;
	
	ГраницаХарактеристик = Макс(Мин(ФормыПроектыКлиентСервер.ЛимитХарактеристик(), ХарактеристикиДетали.Количество()), ФормыПроектыКлиентСервер.ЛимитХарактеристик());
	
	Для ИдКолонки = 1 По ГраницаХарактеристик Цикл
		ТекСтрока = Объект.Детали.НайтиПоИдентификатору(ИдСТроки); // после динамимеского добавления колонки нужно обновить текущую строку
		ИмяЭлементаХарактеристики = ФормыПроектыКлиентСервер.ИмяКолонкиХарактеристики() + ИдКолонки;
		ИмяЭлементаЗначениеХарактеристики = ФормыПроектыКлиентСервер.ИмяКолонкиЗначенияХарактеристики() + ИдКолонки;
		
		Если ХарактеристикиДетали.Количество() >= ИдКолонки Тогда
			СтрокаХарактеристики = ХарактеристикиДетали[ИдКолонки - 1];
			ТекСтрока[ИмяЭлементаХарактеристики] = СтрокаХарактеристики.Характеристика;
			ТекСтрока[ИмяЭлементаЗначениеХарактеристики] = СтрокаХарактеристики.Значение;
			
			ФормыОбщиеДействияСервер.ПривестиРеквизитКТипуХарактеристики(
				ТекСтрока[ИмяЭлементаЗначениеХарактеристики], СтрокаХарактеристики.ТипХарактеристики);
				
			Элементы[ФормыПроектыКлиентСервер.ИмяГруппыДеталиХарактеристики() + ИдКолонки].Видимость = Истина;
			
		Иначе
			ТекСтрока[ИмяЭлементаХарактеристики] = Неопределено;
			ТекСтрока[ИмяЭлементаЗначениеХарактеристики] = Неопределено;
		КонецЕсли;
		
	КонецЦикла;
	
	НазначитьОграничениеТипаЗначХарактеристики(Форма, ИдСтроки);
	
КонецПроцедуры

Процедура НазначитьОграничениеТипаЗначХарактеристики(Форма, ИдСтроки) Экспорт
	
	Объект = Форма.Объект;
	Элементы = Форма.Элементы;
	
	СтрокаТаб = Объект.Детали.НайтиПоИдентификатору(ИдСтроки);
	Для Счетчик = 1 По ФормыПроектыКлиентСервер.ЛимитХарактеристик() Цикл
		ИмяКолонкиЗначенияХарактеристики = ФормыПроектыКлиентСервер.ИмяКолонкиЗначенияХарактеристики() + Счетчик;
		ИмяКолонкиХарактеристики = ФормыПроектыКлиентСервер.ИмяКолонкиХарактеристики() + Счетчик;
		Если ЗначениеЗаполнено(СтрокаТаб[ИмяКолонкиЗначенияХарактеристики]) Тогда
			Элементы[ИмяКолонкиЗначенияХарактеристики].ОграничениеТипа = 
				ФормыОбщиеДействияСервер.ОписаниеТипаХарактеристикиПоЗначению(СтрокаТаб[ИмяКолонкиЗначенияХарактеристики]);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

Функция НайтиДобавитьЭлементыСтрокиДеталей(Форма, ИдКолонки)
	
	Объект = Форма.Объект;
	Элементы = Форма.Элементы;
	
	ИмяРодителяКолонки = ФормыПроектыКлиентСервер.ИмяГруппыДеталиХарактеристики() + ИдКолонки;
	РодительКолонки = Элементы.Найти(ИмяРодителяКолонки);
	Если РодительКолонки = Неопределено Тогда
		// Динамическое добавление в 8.3.10 не подерживается на мобильнике.
		//РодительКолонки = Элементы.Добавить(
		//	ИмяРодителяКолонки,
		//	Тип("ГруппаФормы"),
		//	Элементы.ДеталиГруппаОбщая
		//);
		//РодительКолонки.Группировка = ГруппировкаКолонок.Горизонтальная;
		//РодительКолонки.ОтображатьВШапке = Истина;
		//РодительКолонки.ОтображатьЗаголовок = Истина;
		ВызватьИсключение "Динамическое добавление в 8.3.10 не подерживается на мобильнике";
	КонецЕсли;
	
	ДобавитьРеквизитФормыДляХарактеристики(Форма, ИдКолонки, РодительКолонки);
	ДобавитьРеквизитФормыДляЗначенияХарактеристики(Форма, ИдКолонки, РодительКолонки);
	
КонецФункции

Функция ДобавитьРеквизитФормыДляХарактеристики(Форма, ИдКолонки, РодительЭлементаКолонки)
	
	Объект = Форма.Объект;
	Элементы = Форма.Элементы;
	
	ИмяРеквизита = ФормыПроектыКлиентСервер.ИмяКолонкиХарактеристики() + ИдКолонки;
	
	ЭтоНовый = Ложь;
	Реквизит = ФормыОбщиеДействияСервер.НайтиДобавитьРеквизитФормы(ЭтоНовый,
		Форма,
		ИмяРеквизита, 
		"СправочникСсылка.ФизическиеХарактеристики", 
		"Объект.Детали"
	);
	
	Если Не ЭтоНовый Тогда
		Возврат Реквизит.Имя;
	КонецЕсли;
	
	КолонкаРеквизит = Элементы.Добавить(
		ИмяРеквизита, 
		Тип("ПолеФормы"),
		РодительЭлементаКолонки
	);
	
	КолонкаРеквизит.ПутьКДанным = Реквизит.Путь + "." + ИмяРеквизита;
	КолонкаРеквизит.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Нет;
	
	Возврат КолонкаРеквизит.Имя;
	
КонецФункции

Функция ДобавитьРеквизитФормыДляЗначенияХарактеристики(Форма, ИдКолонки, РодительЭлементаКолонки)
	
	Объект = Форма.Объект;
	Элементы = Форма.Элементы;
	
	ИмяРеквизита = ФормыПроектыКлиентСервер.ИмяКолонкиЗначенияХарактеристики() + ИдКолонки;
	
	ЭтоНовый = Ложь;
	Реквизит = ФормыОбщиеДействияСервер.НайтиДобавитьРеквизитФормы(ЭтоНовый,
		Форма,
		ИмяРеквизита, 
		"Строка,Булево,Число,Дата", 
		"Объект.Детали"
	);
	
	Если Не ЭтоНовый Тогда
		Возврат Реквизит.Имя;
	КонецЕсли;
	
	КолонкаРеквизит = Элементы.Добавить(
		ИмяРеквизита, 
		Тип("ПолеФормы"),
		РодительЭлементаКолонки
	);
	
	КолонкаРеквизит.ПутьКДанным = Реквизит.Путь + "." + ИмяРеквизита;
	КолонкаРеквизит.Вид = ВидПоляФормы.ПолеВвода;
	КолонкаРеквизит.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Нет;
	КолонкаРеквизит.КнопкаВыбора = Ложь;
	
	Возврат КолонкаРеквизит.Имя;
	
КонецФункции

#КонецОбласти

#Область РаботаСФормулами

Процедура РасссчитатьЗначенияФормул(Форма, ИдСтрокиДетали, знач ИменаФормул = Неопределено) Экспорт
	
	Форма.Элементы.ОшибкиРасчетаФормул.Заголовок = "";
	Попытка
		РасссчитатьЗначенияФормулВПопытке(Форма, ИдСтрокиДетали, ИменаФормул);
	Исключение
		Форма.Элементы.ОшибкиРасчетаФормул.Заголовок = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
	КонецПопытки;
	
КонецПроцедуры

Процедура РасссчитатьЗначенияФормулВПопытке(Форма, ИдСтрокиДетали, знач ИменаФормул = Неопределено) Экспорт
	
	Объект = Форма.Объект;
	Элементы = Форма.Элементы;
	
	Если ИдСтрокиДетали = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если ТипЗнч(ИменаФормул) = Тип("Строка") Тогда 
		// единственный элемент
		ИменаФормул = ОбщегоНазначения.ЗначениеВМассив(ИменаФормул);
	КонецЕсли;
	
	Формулы = Новый Массив;
	
	СтрокиФормулы = Объект.Формулы.НайтиСтроки(Новый Структура("ИдСтрокиДетали", ИдСтрокиДетали));
	Если СтрокиФормулы.Количество() > 0 Тогда
		СтрокаФормулы = СтрокиФормулы[0];
	Иначе
		Возврат;
	КонецЕсли;
	
	Если ИменаФормул = Неопределено Тогда
		Для Счетчик = 1 По ФормыПроектыКлиентСервер.ЛимитХарактеристик() Цикл
			СтрокаФормулы[ФормыПроектыКлиентСервер.ИмяРеквизитаЗначениеФормулы() + Счетчик] = 0; // очищаем прошлые значения
			Формула = СтрокаФормулы[ФормыПроектыКлиентСервер.ИмяРеквизитаФормулы() + Счетчик];
			Если ЗначениеЗаполнено(Формула) Тогда
				Формулы.Добавить(Формула);
			КонецЕсли;
		КонецЦикла;
	Иначе
		Для каждого ИмяФормулы Из ИменаФормул Цикл
			ИмяКолонкиЗначФормулы = ФормыПроектыКлиентСервер.ИмяРеквизитаЗначениеФормулы() + Прав(ИмяФормулы, 1);
			СтрокаФормулы[ИмяКолонкиЗначФормулы] = 0; // очищаем прошлые значения
			Формулы.Добавить(СтрокаФормулы[ИмяФормулы]);
		КонецЦикла;
	КонецЕсли;
	
	СтрокаДетали = Объект.Детали.НайтиПоИдентификатору(ИдСтрокиДетали);
	Если СтрокаДетали = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Аргументы = Новый Соответствие;
	Для Счетчик = 1 По ФормыПроектыКлиентСервер.ЛимитХарактеристик() Цикл
		Аргумент = СтрокаДетали[ФормыПроектыКлиентСервер.ИмяКолонкиХарактеристики() + Счетчик];
		ЗначениеАргумента = СтрокаДетали[ФормыПроектыКлиентСервер.ИмяКолонкиЗначенияХарактеристики() + Счетчик];
		Если ЗначениеЗаполнено(Аргумент) Тогда
			Аргументы.Вставить(Аргумент.Наименование, ЗначениеАргумента);
		КонецЕсли;
	КонецЦикла;
	
	КартаРасчета = Справочники.Формулы.РасссчитатьЗначенияФормул(Формулы, Аргументы);
	
	Для каждого КлючФормулы Из КартаРасчета Цикл
		Для Счетчик = 1 По ФормыПроектыКлиентСервер.ЛимитХарактеристик() Цикл
			Формула = СтрокаФормулы[ФормыПроектыКлиентСервер.ИмяРеквизитаФормулы() + Счетчик];
			Если КлючФормулы.Ключ = Формула Тогда
				СтрокаФормулы[ФормыПроектыКлиентСервер.ИмяРеквизитаЗначениеФормулы() + Счетчик] = КлючФормулы.Значение;
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
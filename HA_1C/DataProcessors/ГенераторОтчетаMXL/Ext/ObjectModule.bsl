﻿
// { Plugin interface
Функция ОписаниеПлагина(ВозможныеТипыПлагинов) Экспорт
	Результат = Новый Структура;
	Результат.Вставить("Тип", ВозможныеТипыПлагинов.ГенераторОтчета);
	Результат.Вставить("Идентификатор", Метаданные().Имя);
	Результат.Вставить("Представление", "Отчет о тестировании в формате MXL");
	
	Возврат Новый ФиксированнаяСтруктура(Результат);
КонецФункции

Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
КонецПроцедуры
// } Plugin interface

// { Report generator interface
Функция СоздатьОтчет(КонтекстЯдра, РезультатыТестирования) Экспорт
	ЭтотОбъект.ТипыУзловДереваТестов = КонтекстЯдра.Плагин("ПостроительДереваТестов").ТипыУзловДереваТестов;
	ЭтотОбъект.СостоянияТестов = КонтекстЯдра.СостоянияТестов;
	Отчет = СоздатьОтчетНаСервере(РезультатыТестирования);
	
	Возврат Отчет;
КонецФункции

Функция СоздатьОтчетНаСервере(РезультатыТестирования) Экспорт
	Если (РезультатыТестирования.КоличествоСломанныхТестов = 0) И (РезультатыТестирования.КоличествоОшибочныхТестов = 0) И (РезультатыТестирования.КоличествоНеРеализованныхТестов = 0) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	МакетОтчетТестирования = ПолучитьМакет("ОтчетТестирования");
	Отчет = Новый ТабличныйДокумент;
	ОбластьЗаголовок = МакетОтчетТестирования.ПолучитьОбласть("Заголовок");
	ЗаполнитьЗначенияСвойств(ОбластьЗаголовок.Параметры, РезультатыТестирования);
	ОбластьЗаголовок.Параметры.ВремяВыполненияСтрока = Формат(Дата(1, 1, 1) + РезультатыТестирования.ВремяВыполнения, "ДЛФ=T");
	Отчет.Вывести(ОбластьЗаголовок);
	
	Отчет.НачатьАвтогруппировкуСтрок();
	ВывестиДанныеОтчетаТестированияРекурсивно(ТипыУзловДереваТестов, СостоянияТестов, РезультатыТестирования, МакетОтчетТестирования, Отчет);
	Отчет.ЗакончитьАвтогруппировкуСтрок();
	
	Отчет.ОтображатьСетку = Ложь;
	Отчет.Защита = Ложь;
	Отчет.ТолькоПросмотр = Ложь;
	Отчет.ОтображатьЗаголовки = Ложь;
	
	Возврат Отчет;
КонецФункции

Процедура ВывестиДанныеОтчетаТестированияРекурсивно(ТипыУзловДереваТестов, СостоянияТестов, РезультатыТестирования, МакетОтчетТестирования, Отчет, Уровень = 0)
	Если РезультатыТестирования.Состояние <> СостоянияТестов.Пройден Тогда
		Если РезультатыТестирования.Тип = ТипыУзловДереваТестов.Контейнер Тогда
			ОбластьКонтейнер = МакетОтчетТестирования.ПолучитьОбласть("Контейнер");
			ОбластьКонтейнер.Параметры.ИмяКонтейнера = РезультатыТестирования.Имя;
			Отчет.Вывести(ОбластьКонтейнер, Уровень);
			Для каждого ЭлементКоллекции Из РезультатыТестирования.Строки Цикл
				ВывестиДанныеОтчетаТестированияРекурсивно(ТипыУзловДереваТестов, СостоянияТестов, ЭлементКоллекции, МакетОтчетТестирования, Отчет, Уровень + 1);
			КонецЦикла;
		Иначе
			ОбластьЭлемент = МакетОтчетТестирования.ПолучитьОбласть("Элемент");
			ОбластьЭлемент.Параметры.ИмяМетода = РезультатыТестирования.Представление;
			ОбластьЭлемент.Параметры.Путь = РезультатыТестирования.Путь;
			ОбластьЭлемент.Параметры.Сообщение = РезультатыТестирования.Сообщение;
			ОбластьЭлемент.Области.Элемент.Отступ = Уровень * 2;
			Отчет.Вывести(ОбластьЭлемент, Уровень);
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

#Если ТолстыйКлиентОбычноеПриложение Тогда
Процедура Показать(Отчет) Экспорт
	Если Отчет <> Неопределено Тогда
		ЗаголовокОкнаОтчета = НСтр("ru = 'Отчет об автоматическом тестировании'");
		Отчет.Показать(ЗаголовокОкнаОтчета);
	КонецЕсли;
КонецПроцедуры
#КонецЕсли

Процедура Экспортировать(Отчет, ПолныйПутьФайла) Экспорт
	ВызватьИсключение "Метод не реализован";
КонецПроцедуры
// } Report generator interface

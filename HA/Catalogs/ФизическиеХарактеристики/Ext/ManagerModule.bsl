﻿
#Область ПрограммныйИнтерфейс
Функция ТипХарактеристикиПоСсылке(ХарактеристикаСсылка) Экспорт
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	ФизическиеХарактеристики.ЕдиницаИзмерения.ТипХарактеристики КАК ТипХарактеристики
	|ИЗ
	|	Справочник.ФизическиеХарактеристики КАК ФизическиеХарактеристики
	|ГДЕ
	|	ФизическиеХарактеристики.Ссылка = &Ссылка");
	Запрос.УстановитьПараметр("Ссылка", ХарактеристикаСсылка);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		Возврат Выборка.ТипХарактеристики;
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
КонецФункции

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияПолейПредставления(Поля, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Поля = Новый Массив;
	Поля.Добавить("Наименование");
	Поля.Добавить("ЭтоГруппа");
	Поля.Добавить("ЕдиницаИзмерения");
	
КонецПроцедуры

Процедура ОбработкаПолученияПредставления(Данные, Представление, СтандартнаяОбработка)
	
	Если Данные.ЭтоГруппа Или Не ЗначениеЗаполнено(Данные.ЕдиницаИзмерения) Тогда
		Возврат;
	КонецЕсли;
	
	СтандартнаяОбработка = Ложь;
	Представление = СтрШаблон("%1 (%2)", Данные.Наименование, Данные.ЕдиницаИзмерения);
	
КонецПроцедуры

#КонецОбласти
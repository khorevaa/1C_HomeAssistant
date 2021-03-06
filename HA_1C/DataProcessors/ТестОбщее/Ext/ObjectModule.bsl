﻿Перем КонтекстЯдра;
Перем Ожидаем;

Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
	КонтекстЯдра = КонтекстЯдраПараметр;
	Ожидаем = КонтекстЯдра.Плагин("УтвержденияBDD");
	
КонецПроцедуры

Функция ПолучитьСписокТестов() Экспорт
	ВсеТесты = Новый Массив;
	ВсеТесты.Добавить("ТестПервоначальноеЗаполнение");
	
	Возврат ВсеТесты;
КонецФункции

Процедура ТестПервоначальноеЗаполнение() Экспорт
	
	ОбновлениеИнформационнойБазыВызовСервера.ЗапуститьОбновление();
	
	Тонна = Справочники.КлассификаторЕдиницИзмерения.НайтиПоКоду(168);
	
	Ожидаем
	.Что(СокрЛП(Тонна.Код))
	.Равно("168");
	
КонецПроцедуры

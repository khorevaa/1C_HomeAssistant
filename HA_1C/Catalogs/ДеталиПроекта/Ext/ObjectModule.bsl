﻿
Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если Не ЭтоГруппа И Не ЗначениеЗаполнено(Родитель) Тогда
		Родитель = Справочники.ДеталиПроекта.Комплектующие;
	КонецЕсли;
	
КонецПроцедуры

﻿
Функция ОтчетныеПоказатели() Экспорт
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	КОЛИЧЕСТВО(*) КАК Количество,
	|	СУММА(ВЫБОР
	|			КОГДА НЕ Проекты.Завершен
	|				ТОГДА 1
	|			ИНАЧЕ 0
	|		КОНЕЦ) КАК Активных
	|ИЗ
	|	Справочник.Проекты КАК Проекты");
	Выборка = Запрос.Выполнить().Выбрать();
	Количество = 0;
	Активных = 0;
	Если Выборка.Следующий() Тогда
		Количество = Выборка.Количество;
		Активных = Выборка.Активных;
	КонецЕсли;
	
	Показатели = Новый Соответствие;
	Показатели.Вставить(НСтр("ru = 'Активных:'; en = 'Active:'"), Активных);
	Показатели.Вставить(НСтр("ru = 'Всего:'; en = 'Total:'"), Количество);
	
	Возврат Показатели;
	
КонецФункции

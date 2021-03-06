﻿//////////////////////////////////////////////////////////////////////////////////////////
// Интерфейс работы с прикрепленными файлами на мобильном устройстве (клиент)
// 
//////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Делает фотографию при помощи камеры устройства, по настройкам пользователя и упаковывает полученные данные в структуру
//
// Параметры:
//  КачествоСнимка	 - Число - Качество снимка в %
//  ВладелецХранилища	 - УправляемаяФорма или УникальныйИдентификатор - Форма-владелец будущего файла или уникальный идентификатор для сохранения во временном хранилище
// 
// Возвращаемое значение:
//  Структура - Упакованные данные снимка (см. СтруктураФайлаИзДанныхМультимедиа)
//
Функция НоваяФотография(КачествоСнимка = 80, ВладелецХранилища = Неопределено) Экспорт
	
	Данные = Неопределено;
	#Если МобильноеПриложениеКлиент Тогда
		ТипКамеры = ТипКамерыУстройства.Авто;
		Данные = УправлениеМультимедиаКлиент.СделатьФотографию(ТипКамеры, КачествоСнимка); 
	#КонецЕсли
	
	Если Данные = Неопределено Тогда
		Возврат Неопределено
	КонецЕсли;
	
	Возврат СтруктураФайлаИзДанныхМультимедиа(Данные, ПредопределенноеЗначение("Перечисление.СпособОткрытияПрикрепленногоФайла.КакИзображение"), ВладелецХранилища);
	
КонецФункции

// Делает аудиозапись средствами устройства и упаковывает полученные данные в структуру
//
// Параметры:
//  ВладелецХранилища	 - УправляемаяФорма или УникальныйИдентификатор - Форма-владелец будущего файла или уникальный идентификатор для сохранения во временном хранилище
// 
// Возвращаемое значение:
//  Структура - Упакованные данные снимка (см. СтруктураФайлаИзДанныхМультимедиа)
//
Функция НоваяАудиозапись(ВладелецХранилища = Неопределено) Экспорт
	
	Данные = Неопределено;
	#Если МобильноеПриложениеКлиент Тогда		
		Данные = УправлениеМультимедиаКлиент.СделатьАудиозапись(); 
	#КонецЕсли
	
	Если Данные = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
		
	Возврат СтруктураФайлаИзДанныхМультимедиа(Данные, ПредопределенноеЗначение("Перечисление.СпособОткрытияПрикрепленногоФайла.КакИзображение"), ВладелецХранилища);
	
КонецФункции

// Открывает фотографию из библиотеки ОС
//
// Параметры:
//  ВладелецХранилища	 - УправляемаяФорма или УникальныйИдентификатор - Форма-владелец будущего файла или уникальный идентификатор для сохранения во временном хранилище
// 
// Возвращаемое значение:
//  Структура - Упакованные данные снимка (см. СтруктураФайлаИзФайлаОС)
//
Функция НоваяКартинкаИзФайла(ВладелецХранилища = Неопределено) Экспорт
	
	Данные = Неопределено;
	Данные = УправлениеМультимедиаКлиент.ОткрытьКартинкуИзПамяти();
	
	Если Данные = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Возврат СтруктураФайлаИзФайлаОС(Данные, ПредопределенноеЗначение("Перечисление.СпособОткрытияПрикрепленногоФайла.КакИзображение"), ВладелецХранилища);
	
КонецФункции

// Открывает редактор картинок и ожидает, когда пользователь завершит работу
// и возвращает отредактированную картинку в 1С
//
// Параметры:
//  Адрес             - Адрес - Адрес на временное хранилище или навигационная ссылка, в которой хранится картинка.
//  ВладелецХранилища	 - УправляемаяФорма или УникальныйИдентификатор - Форма-владелец будущего файла или уникальный идентификатор для сохранения во временном хранилище
//
//  Структура - Упакованные данные снимка (см. СтруктураФайлаИзФайлаОС)
//
Функция НоваяОтредактированнаяКартинкаИзФайла(Адрес, ВладелецХранилища = Неопределено) Экспорт
	
	Данные = Неопределено;
	Данные = УправлениеМультимедиаКлиент.ИзменитьФотоВPaint(Адрес);
	
	Если Данные = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Возврат СтруктураФайлаИзФайлаОС(Данные, ПредопределенноеЗначение("Перечисление.СпособОткрытияПрикрепленногоФайла.КакИзображение"), ВладелецХранилища);
	
КонецФункции

// Возвращает имя события сделанной фотографии/исполненной аудиозаписи, для использования в событии ОбработкаОповещения
// 
// Возвращаемое значение:
//  Строка - Имя события
//
Функция ИмяСобытияГенерацииМультимедиа() Экспорт
	
	Возврат "ГенерацияМультимедиа";
	
КонецФункции

// Возвращает имя события сделанной фотографии/исполненной аудиозаписи, для использования в событии ОбработкаОповещения
// 
// Возвращаемое значение:
//  Строка - Имя события
//
Функция ИмяСобытияИзменениеСпискаМультимедиа() Экспорт
	
	Возврат "ИзменениеСпискаМультимедиа";
	
КонецФункции

// Проверяет пришедшее событие на генерацию мультимедиа данных для текущей формы
//
// Параметры:
//  ЭтаФорма	 - УправляемаяФорма - контекст текущей формы
//  ИмяСобытия	 - Строка - Имя текущего события
//  Параметр	 - Произвольный - Параметр события
//  Источник	 - Произвольный - Источник события
// 
// Возвращаемое значение:
//  Истина - если событие есть генерация мультимедиа для текущей формы
//
Функция ЭтоГенерацияМультимедиа(ЭтаФорма, ИмяСобытия, Источник) Экспорт
	Возврат (ИмяСобытия = ИмяСобытияГенерацииМультимедиа()) И (Источник = ЭтаФорма);
КонецФункции

// Проверяет пришедшее событие на генерацию мультимедиа данных для текущей формы
//
// Параметры:
//  ЭтаФорма	 - УправляемаяФорма - контекст текущей формы
//  ИмяСобытия	 - Строка - Имя текущего события
//  Параметр	 - Произвольный - Параметр события
//  Источник	 - Произвольный - Источник события
// 
// Возвращаемое значение:
//  Истина - если событие есть генерация мультимедиа для текущей формы
//
Функция ЭтоИзменениеСпискаМультимедиа(ЭтаФорма, ИмяСобытия, Источник) Экспорт
	Возврат (ИмяСобытия = ИмяСобытияИзменениеСпискаМультимедиа()) И (Источник = ЭтаФорма);
КонецФункции

// Проверяет - является ли прикрепленный файл изображением
//
// Параметры:
//  СпособОткрытия	 - Перечисление.СпособОткрытияПрикрепленногоФайла - Способ открытия текущего прикрепленного файла
// 
// Возвращаемое значение:
//  Булево - Истина, если прикрепленный файл является изображением
//
Функция ЭтоИзображение(СпособОткрытия) Экспорт
	
	Возврат СпособОткрытия = ПредопределенноеЗначение("Перечисление.СпособОткрытияПрикрепленногоФайла.КакИзображение");
	
КонецФункции

// Проверяет - является ли прикрепленный файл аудиофайлом
//
// Параметры:
//  СпособОткрытия	 - Перечисление.СпособОткрытияПрикрепленногоФайла - Способ открытия текущего прикрепленного файла
// 
// Возвращаемое значение:
//  Булево - Истина, если прикрепленный файл является аудиофайлом
//
Функция ЭтоАудиоФайл(СпособОткрытия) Экспорт
	
	Возврат СпособОткрытия = ПредопределенноеЗначение("Перечисление.СпособОткрытияПрикрепленногоФайла.КакАудиоФайл");
	
КонецФункции

// Воспроизводит медиа в зависимоти от его типа
//
// Параметры:
//	Адрес	- Расположение данных во временном хранилище или в информационной базе
//	СпособОткрытия - ПеречислениеСсылка.СпособОткрытияПрикрепленногоФайла - способ, которым платформа может обработать файл
//	Расширение - Строка - расширение файла
//	Наименование - Строка - наименование файла
//
Процедура ВоспроизвестиМедиа(Адрес, СпособОткрытия, Расшинение, Наименование) Экспорт
	
	ИмяФайла = ВыгрузитьДанныеВФайл(Адрес, Расшинение, Наименование);
	
	Если ИмяФайла = "" Тогда
		Сообщить(НСтр("ru='Не получилось выгрузить данные в файл'"));
	Иначе
		ОткрытьФайлКакПриложение(ИмяФайла);	
	КонецЕсли;
	
КонецПроцедуры

// Открывает указанный файл в ОС пользователя как приложение
//
//Параметры:
//	ИмяФайла	- Строка - Имя открываемого фала
//
Процедура ОткрытьФайлКакПриложение(ИмяФайла) Экспорт
	
	Если ПустаяСтрока(ИмяФайла) Тогда
		Возврат;
	КонецЕсли;
	
	ЗапуститьПриложение(ИмяФайла,, Истина);	
	
	//ОбщегоНазначенияДеньгиКлиентСервер.УдалитьВременныеФайлы(ИмяФайла);
	
КонецПроцедуры

// Добавляет в списко структуру медиа-файла и обновляет описание списка
Процедура ДобавитьМедиаВСписок(СписокФайлов, ПредставлениеСписка, Данные) Экспорт
	
	Если (СписокФайлов = Неопределено) ИЛИ (ТипЗнч(СписокФайлов) <> Тип("СписокЗначений")) ИЛИ (ТипЗнч(Данные) <> Тип("Структура")) Тогда
		Возврат;
	КонецЕсли;
	
	СписокФайлов.Добавить(Данные);	
	Если ПредставлениеСписка <> Неопределено Тогда
		ПредставлениеСписка = ПрикрепленныеФайлыКлиентСервер.ПолучитьОписаниеСпискаМедиаФайлов(СписокФайлов);
	КонецЕсли;	
	
КонецПроцедуры

// Добавляет в реквизит Медиафайлы указанной формы новый медиафайл, описанный в структуре 
//
//Параметры:
//	Форма - управляемая форма, в список которой нужно добавить файл
//	СтруктураФайла - Структуа - результат функции ПрикрепленныеФайлыКлиентСервер.НоваяСтруктураПрикрепляемогоФайла()
//
Процедура ДобавитьФайлВСписокФормы(Форма, СтруктураФайла) Экспорт
	
	Если ТипЗнч(СтруктураФайла) <> Тип("Структура") Тогда
		Возврат;
	КонецЕсли;
	
	Форма.Медиафайлы.Добавить(СтруктураФайла, СтруктураФайла.Наименование);
	ПрикрепленныеФайлыКлиентСервер.ОбновитьПредставлениеМедиафайлов(Форма);
	Форма.Модифицированность = Истина;
	
КонецПроцедуры

// Отобразить список прикрпленных файлов
//
// Параметры:
//  СписокФайлов - СписокЗначений - список прикрпленных файлов
//
Процедура ОтобразитьСписокПрикрпленныхФайлов(СписокФайлов) Экспорт
	
	Если (СписокФайлов = Неопределено) ИЛИ (СписокФайлов.Количество() = 0) Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура("СписокФайлов", СписокФайлов);
	ОткрытьФорму("РегистрСведений.ПринадлежностьФайлов.Форма.СписокФайловОбъекта", ПараметрыФормы);	
	
КонецПроцедуры

// Получает файл из временного хранилища или из базы данных и сохраняет в локальную файловую систему пользователя.
//
//Параметры:
//	Адрес	- Расположение данных во временном хранилище или в информационной базе
//	Расширение - Строка - расширение файла
//	Наименование - Строка - наименование файла
//
//Возвращаемое значение:
//	Строка - Имя файла, в который выгружены медиаланные
//
Функция ВыгрузитьДанныеВФайл(Адрес, Расширение, Наименование) Экспорт

	Если Не ЗначениеЗаполнено(Адрес) Тогда
		Возврат "";
	КонецЕсли;
	
	ИмяФайла = "";
	Если Наименование = "" Тогда
		ИмяФайла = ПолучитьИмяВременногоФайла(Расширение);
	Иначе
		Имяфайла = КаталогВременныхФайлов() + ПрикрепленныеФайлыКлиентСервер.НаименованиеБезСлужебныхСимволов(Наименование) + "." + Расширение;
	КонецЕсли;
	
	Если Не ПолучитьФайл(Адрес, ИмяФайла, Ложь) Тогда
		ИмяФайла = "";
	КонецЕсли;
	
	Возврат ИмяФайла;

КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// На основе ДанныхМультимедиа готовит и возвращает структуру, описывающую прикрепляемый файл и пригодную 
//для использования как на сервере, так и на клиенте.
//	Двоичные данные помещаются во временное хранилище либо с идентификатором формы, либо с произвольным уникатльным идентификатором
//
// Параметры:
//  Мультимедиа			 - ДанныеМультимедиа						 - Данные мультимедиа, пришедшие с устройства
//  СпособОткрытия		 - Перечисление.СпособОткрытияПрикрепленногоФайла	 - Способ открытия переданных данных мультимедиа
//  ВладелецХранилища	 - УправляемаяФорма или УникальныйИдентификатор - Форма-владелец будущего файла или уникальный идентификатор для сохранения во временном хранилище
// 
// Возвращаемое значение:
//  Структура (см. ПрикрепленныеФайлыКлиентСервер.НоваяСтруктураПрикрепляемогоФайла()) или НЕОПРЕДЕЛЕНО 
//в случае, если устройство не поддерживает мультимедиа
//
Функция СтруктураФайлаИзДанныхМультимедиа(Мультимедиа, СпособОткрытия, ВладелецХранилища = Неопределено)
	
	Если Мультимедиа = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;	
	
	#Если НЕ МобильноеПриложениеКлиент Тогда	
		Возврат Неопределено;	
	#КонецЕсли
	
	Результат = ПрикрепленныеФайлыКлиентСервер.НоваяСтруктураПрикрепляемогоФайла();
	Результат.СпособОткрытия = СпособОткрытия;
	//Результат.Расширение     = Мультимедиа.РасширениеФайла;
	Результат.ДатаСоздания   = ТекущаяДата();
	
	ИД = Неопределено; 
	Если ТипЗнч(ВладелецХранилища) = Тип("УправляемаяФорма") Тогда
		ИД = ВладелецХранилища.УникальныйИдентификатор;
	ИначеЕсли ТипЗнч(ВладелецХранилища) = Тип("УникальныйИдентификатор") Тогда
		ИД = ВладелецХранилища;
	КонецЕсли;
	
	Результат.НавигационнаяСсылка = ПоместитьВоВременноеХранилище(Мультимедиа.ПолучитьДвоичныеДанные(), ИД);
	
	Результат.Наименование = ПрикрепленныеФайлыКлиентСервер.АвтоНаименованиеФайла(СпособОткрытия, Результат.ДатаСоздания);
	
	Возврат Результат;

КонецФункции

// На основе ДанныхМультимедиа готовит и возвращает структуру, описывающую прикрепляемый файл и пригодную 
//для использования как на сервере, так и на клиенте.
//	Двоичные данные помещаются во временное хранилище либо с идентификатором формы, либо с произвольным уникатльным идентификатором
//
// Параметры:
//  Мультимедиа			 - ДанныеМультимедиа						 - Данные мультимедиа, пришедшие с устройства
//  СпособОткрытия		 - Перечисление.СпособОткрытияПрикрепленногоФайла	 - Способ открытия переданных данных мультимедиа
//  ВладелецХранилища	 - УправляемаяФорма или УникальныйИдентификатор - Форма-владелец будущего файла или уникальный идентификатор для сохранения во временном хранилище
// 
// Возвращаемое значение:
//  Структура (см. ПрикрепленныеФайлыКлиентСервер.НоваяСтруктураПрикрепляемогоФайла()) или НЕОПРЕДЕЛЕНО 
//в случае, если устройство не поддерживает мультимедиа
//
Функция СтруктураФайлаИзФайлаОС(Мультимедиа, СпособОткрытия, ВладелецХранилища = Неопределено)

	Если Мультимедиа = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;

	Результат = ПрикрепленныеФайлыКлиентСервер.НоваяСтруктураПрикрепляемогоФайла();
	Результат.СпособОткрытия = СпособОткрытия;
	Результат.Расширение     = Мультимедиа.РасширениеФайла;
	Результат.ДатаСоздания   = ТекущаяДата();
	
	ИД = Неопределено; 
	Если ТипЗнч(ВладелецХранилища) = Тип("УправляемаяФорма") Тогда
		ИД = ВладелецХранилища.УникальныйИдентификатор;
	ИначеЕсли ТипЗнч(ВладелецХранилища) = Тип("УникальныйИдентификатор") Тогда
		ИД = ВладелецХранилища;
	КонецЕсли;
	
	Результат.НавигационнаяСсылка = ПоместитьВоВременноеХранилище(Мультимедиа.Файл.ПолучитьДвоичныеДанные(), ИД);
	
	Результат.Наименование = ПрикрепленныеФайлыКлиентСервер.АвтоНаименованиеФайла(СпособОткрытия, Результат.ДатаСоздания);
	
	Возврат Результат;

КонецФункции

#КонецОбласти

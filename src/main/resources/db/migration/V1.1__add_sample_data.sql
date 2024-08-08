
INSERT INTO PROFESSION
    (DESCRIPTION)
VALUES
    ('Ingeniero de Sistemas'),
    ('Ingeniero en Computacion'),
    ('Consultor');


INSERT INTO ATTENDEE
    (NAME, LAST_NAME, EMAIL, GENDER, DATE_OF_BIRTH, PROFESSION_ID)
VALUES
    ('Armando Jose', 'Alaniz Aragon', 'armando.alaniz@test.com', 'MALE', '1983-11-13', 1),
    ('Francisco Jose', 'Contreras Garcia', 'francisco.contreras@test.com', 'MALE', '1985-11-09', 1),
    ('Luis Alberto', 'Guido Calderon', 'luis.guido@test.com', 'MALE', '1985-05-29', 1),
    ('Omar David', 'Berroterán Silva', 'omar.berroteran@test.com', 'MALE', '1980-05-09', 3),
    ('Norman Jose', 'Cash Arcia', 'norman.cash@test.com', 'MALE', '1974-08-23', 2),
    ('Luis', 'Mejia', 'luis.mejia@test.com', 'MALE', '1985-08-10', 1);


INSERT INTO VENUE
    (NAME, SHORT_NAME, ADDRESS, CITY, STATE, LOCATION)
VALUES
    ('Universidad Americana', 'UAM', 'Costado Noroeste Camino de Oriente', 'Managua', 'Managua', POINT(12.108572545959579, -86.25713835488897)),
    ('NicaSource S.A.', 'NicaSource', 'Mirador Norte, KM 8.5 Carretera Masaya De semáforos Santo Domingo 2 c oeste, 25 vrs sur', 'Managua', 'Managua', POINT(12.093749569987931, -86.24114381534368)),
    ('Holiday Inn Express Managua', 'IHG', 'De la Rotonda, Blvd. Jean Paul Genie, 800 Mts al Oeste Carr. a Masaya', 'Managua', 'Managua', POINT(12.104443502768314, -86.25606773068736));


INSERT INTO EVENT
    (NAME, TAGS, SCHEDULED_DATE, START_ON, END_ON, VENUE_ID, ROOM, STATUS)
VALUES
    ('Explora el mundo de los API Gateways con Spring Cloud y AWS',
    '["AWS", "Spring Cloud", "Spring Cloud Gateway", "SpringBoot", "Spring", "Java"]',
    '2024-02-24',
    '14:00:00',
    '17:00:00',
    2,
    'Salon de conferencias',
    'ENDED');


INSERT INTO TALK
    (NAME, DESCRIPTION, LEVEL, TAGS, SPEAKER_ID, EVENT_ID, START_ON, END_ON, STATUS)
VALUES
    ('Crea tu propio API Gateway con Spring Cloud Gateway',
    'Imagina poder diseñar y desplegar tu propio API Gateway personalizado, optimizado para las necesidades específicas de tu microservicio o aplicación. En esta charla te llevaremos de la mano a través del proceso de construcción de una API Gateway usando Spring Cloud Gateway. Descubrirás como este proyecto te permite simplificar la interconexión de servicios, gestionar la seguridad, y aplicar políticas de enrutamiento y filtrado. Únete a nosotros para transformar tu enfoque de gestión de APIs y llevar tus habilidades de desarrollo a la próxima frontera.',
    'INTERMEDIATE',
    '["Spring Cloud", "Spring Cloud Gateway", "SpringBoot", "Spring", "Java", "API Gateway"]',
    1,
    1,
    '14:00:00',
    '15:00:00',
    'ENDED'),
    ('Amazon Web Services: API Gateway con Web Sockets',
    'Esta charla explora el desarrollo de aplicaciones interactivas en tiempo real, utilizando la tecnología WebSocket para facilitar la comunicación bidireccional entre el cliente y el servidor. Al concentrarnos en el ecosistema de AWS y el lenguaje de programación Java, los asistentes aprenderán cómo diseñar y construir aplicaciones que requieren interacciones en tiempo real, como chats en vivo, juegos multijugador y plataformas de colaboración en línea.',
    'INTERMEDIATE',
    '["AWS", "WebSockets", "Python", "API Gateway"]',
    2,
    1,
    '15:30:00',
    '16:30:00',
    'ENDED');


INSERT INTO EVENT_ATTENDANCE
    (EVENT_ID, ATTENDEE_ID, CREATED_ON)
VALUES
    (1, 1, '2024-02-24 13:40'),
    (1, 2, '2024-02-24 13:45'),
    (1, 3, '2024-02-24 13:50'),
    (1, 4, '2024-02-24 13:40');


INSERT INTO EVENT
    (NAME, TAGS, SCHEDULED_DATE, START_ON, END_ON, VENUE_ID, ROOM, STATUS)
VALUES
    ('Mobile y Entrevistas de trabajo',
    '["Android", "Jetpack Compose", "Habilidades blandas", "Entrevistas", "Trabajo Remoto"]',
    '2024-04-27',
    '14:00:00',
    '17:00:00',
    1,
    'Aula B-101',
    'ENDED');


INSERT INTO TALK
    (NAME, DESCRIPTION, LEVEL, TAGS, SPEAKER_ID, EVENT_ID, START_ON, END_ON, STATUS)
VALUES
    ('Jetpack Compose es una sistema de creación de interfaces declarativas para Android',
    'Como tendencia hoy en día en cuanto a creación de interfaces en cualquier entorno. Seguramente esta tendencia se empezó a popularizar con React, pero luego la hemos visto en marcha en iOS con Swift UI, en Flutter, y seguramente muchas otras que me estoy dejando por el camino. Las interfaces declarativas consisten en sistemas de vistas que utilizan el paradigma de la programación declarativa: Con Compose decimos cómo queremos que sean las vistas, en lugar de especificar todos los pasos de implementación.',
    'INTERMEDIATE',
    '["Android", "Jetpack Compose"]',
    5,
    2,
    '14:00:00',
    '15:00:00',
    'ENDED'),
    ('Tips para sobrevivir a una entrevista técnica',
    'La ronda de entrevistas técnicas suele ser uno de los pasos mas retadores cuando se aplica a un nuevo rol. Las evaluaciones técnicas son tan variadas que pueden ir desde hacer live coding durante la entrevista hasta resolver retos por cuenta propia desde la comodidad de tu hogar. Las entrevistas técnicas son tan variables y subjetivas, que aunque la compañía tenga un formato definido, las preguntas y valoración del candidato van a depender de quien realiza la entrevista (ya sea el CTO, Technical Lead, u otro developer). A mi me ha tocado entrevistar y ser entrevistado y me gustaría compartirte algunos tips que he aprendido con los años de como mejorar tu rendimiento en una entrevista técnica.',
    'BEGINNER',
    '["Habilidades blandas", "Entrevistas", "Trabajo Remoto"]',
    1,
    2,
    '15:30:00',
    '16:30:00',
    'ENDED');


INSERT INTO EVENT_ATTENDANCE
    (EVENT_ID, ATTENDEE_ID, CREATED_ON)
VALUES
    (2, 1, '2024-04-27 13:35'),
    (2, 2, '2024-04-27 13:35'),
    (2, 3, '2024-04-27 13:40'),
    (2, 4, '2024-04-27 13:40'),
    (2, 5, '2024-04-27 13:35'),
    (2, 6, '2024-04-27 13:35');


INSERT INTO EVENT
    (NAME, TAGS, SCHEDULED_DATE, START_ON, END_ON, VENUE_ID, ROOM, STATUS)
VALUES
    ('Fin de año: Trabajo Remoto y Monitorizacion con Microprofile',
    '["Habilidades blandas", "Entrevistas", "Trabajo Remoto", "Microprofile", "JakartaEE"]',
    '2023-12-02',
    '14:00:00',
    '17:00:00',
    3,
    'Auditorio 3',
    'ENDED');


INSERT INTO TALK
    (NAME, DESCRIPTION, LEVEL, TAGS, SPEAKER_ID, EVENT_ID, START_ON, END_ON, STATUS)
VALUES
    ('5 errores que debes evitar al postularte a un trabajo remoto',
    'Luis Mejía ha trabajado para distintas empresas internacionales(GitLab, Appsumo, Synack, Spectora) como Senior Backend Engineer Backend Engineer y en su tiempo libre ofrece sus servicios como mentor para Devs que buscan trabajo remoto con salario internacional',
    'GENERAL',
    '["Habilidades blandas", "Entrevistas", "Trabajo Remoto"]',
    6,
    3,
    '14:00:00',
    '15:00:00',
    'ENDED'),
    ('Observabilidad y Monitoreo de aplicaciones usando Microprofile',
    '',
    'INTERMEDIATE',
    '["Microprofile", "JakartaEE"]',
    2,
    3,
    '15:30:00',
    '16:30:00',
    'ENDED');


INSERT INTO EVENT_ATTENDANCE
    (EVENT_ID, ATTENDEE_ID, CREATED_ON)
VALUES
    (3, 1, '2023-12-02 13:35'),
    (3, 2, '2023-12-02 13:35'),
    (3, 3, '2023-12-02 13:40'),
    (3, 4, '2023-12-02 13:40'),
    (3, 5, '2023-12-02 13:55'),
    (3, 6, '2023-12-02 13:55');


INSERT INTO EVENT
    (NAME, TAGS, SCHEDULED_DATE, START_ON, END_ON, VENUE_ID, ROOM, STATUS)
VALUES
    ('Explorando Java y Spring para Desarrollo de Software',
    '["Java", "SpringBoot", "Spring", "DI"]',
    '2023-08-26',
    '13:00:00',
    '16:00:00',
    1,
    'Aula D-101',
    'ENDED');


INSERT INTO TALK
    (NAME, DESCRIPTION, LEVEL, TAGS, SPEAKER_ID, EVENT_ID, START_ON, END_ON, STATUS)
VALUES
    ('Tu Primera Aplicación Web con Java',
    'Si estás recién comenzando en el desarrollo web y ansías aprender, esta charla es perfecta para ti. Únete a nosotros mientras exploramos el emocionante mundo de Java en el contexto de las aplicaciones web. Enfocada en los conceptos básicos, esta charla te introducirá a las opciones más sencillas y efectivas para crear tu primera aplicación web utilizando Java. A medida que avanzamos, irás adquiriendo el conocimiento necesario para estructurar tu proyecto gradualmente. Empezaremos desde un nivel principiante y escalaremos hacia sistemas más complejos. Esta charla te brindará la base sólida que necesitas para comenzar a construir tus propias aplicaciones web con confianza.',
    'BEGINNER',
    '["Java"]',
    4,
    4,
    '13:00:00',
    '14:00:00',
    'ENDED'),
    ('Entendiendo la Inyección de Dependencias con Spring',
    'En esta charla emocionante, Armando te guiará a través del complejo pero esencial concepto de Inyección de Dependencias empleando la poderosa herramienta Spring. La Inyección de Dependencias es un principio crucial dentro de los principios SOLID de programación y una habilidad indispensable para desarrolladores de aplicaciones empresariales. Armando explorará las diversas alternativas para inyectar componentes en Spring, brindándote una comprensión profunda de cómo estructurar tu código de manera eficiente y modular. Además, aprenderás sobre los diferentes alcances (scopes) al inyectar dependencias y cómo aprovecharlos para mejorar el rendimiento y la flexibilidad de tus aplicaciones.',
    'BEGINNER',
    '["Java", "SpringBoot", "Spring", "DI"]',
    1,
    4,
    '14:30:00',
    '15:30:00',
    'ENDED');


INSERT INTO EVENT_ATTENDANCE
    (EVENT_ID, ATTENDEE_ID, CREATED_ON)
VALUES
    (4, 1, '2023-08-26 12:35'),
    (4, 2, '2023-08-26 12:35'),
    (4, 3, '2023-08-26 12:40'),
    (4, 4, '2023-08-26 12:40'),
    (4, 5, '2023-08-26 12:55'),
    (4, 6, '2023-08-26 12:55');

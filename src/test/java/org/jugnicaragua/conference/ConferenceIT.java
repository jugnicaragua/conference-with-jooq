package org.jugnicaragua.conference;

import org.jooq.Condition;
import org.jooq.DSLContext;
import org.jooq.Field;
import org.jooq.Record1;
import org.jooq.Result;
import org.jugnicaragua.conference.jooq.tables.records.ProfessionRecord;
import org.jugnicaragua.conference.jooq.tables.records.TalkRecord;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatList;
import static org.assertj.core.api.Assertions.fail;
import static org.jooq.Records.mapping;
import static org.jooq.impl.DSL.concat;
import static org.jooq.impl.DSL.count;
import static org.jooq.impl.DSL.inline;
import static org.jooq.impl.DSL.max;
import static org.jooq.impl.DSL.min;
import static org.jooq.impl.DSL.noCondition;
import static org.jugnicaragua.conference.jooq.tables.Attendee.ATTENDEE;
import static org.jugnicaragua.conference.jooq.tables.Event.EVENT;
import static org.jugnicaragua.conference.jooq.tables.Profession.PROFESSION;
import static org.jugnicaragua.conference.jooq.tables.Talk.TALK;
import static org.junit.jupiter.api.Assertions.assertFalse;

@SpringBootTest
@Transactional
class ConferenceIT {

    private static final Logger LOGGER = LoggerFactory.getLogger(ConferenceIT.class);

    @Autowired
    private DSLContext create;

    @Autowired
    private DataSource dataSource;

    @Test
    void test_insert_into() {
        int rows = create.insertInto(PROFESSION,
                        PROFESSION.DESCRIPTION)
                .values("Estudiante")
                .values("Freelancer")
                .execute();

        assertThat(rows).isEqualTo(2);
    }

    @Test
    void test_insert_into_and_return_generated_id() {
        Result<Record1<Integer>> result = create.insertInto(PROFESSION,
                        PROFESSION.DESCRIPTION)
                .values("Software Developer")
                .values("Analista Programador")
                .returningResult(PROFESSION.PROFESSION_ID)
                .fetch();

        List<Integer> ids = result.getValues(PROFESSION.PROFESSION_ID);

        LOGGER.debug("{} table -> IDs generated: {}", PROFESSION.getName(), ids);

        assertThatList(result).hasSize(2);
    }

    @Test
    void test_update() {
        Integer id = createProfession("Test");

        var newProfession = "Fullstack developer";
        create.update(PROFESSION)
                .set(PROFESSION.DESCRIPTION, newProfession)
                .where(PROFESSION.PROFESSION_ID.eq(id))
                .execute();

        ProfessionRecord professionRecord = create.selectFrom(PROFESSION)
                .where(PROFESSION.PROFESSION_ID.eq(id))
                .fetchOne();

        assertThat(professionRecord.getDescription()).isEqualTo(newProfession);
    }

    @Test
    void test_delete() {
        Integer id = createProfession("Frontend developer");
        create.deleteFrom(PROFESSION)
                .where(PROFESSION.PROFESSION_ID.eq(id))
                .execute();

        boolean exists = create.fetchExists(PROFESSION, PROFESSION.PROFESSION_ID.eq(id));

        assertFalse(exists);
    }

    @Test
    void test_record_save() {
        ProfessionRecord record = create.newRecord(PROFESSION);

        record.setDescription("QA")
                .store();

        LOGGER.debug("ID generated: {}", record.getProfessionId());

        assertThat(record.getProfessionId()).isNotNull();
    }

    @Test
    void test_record_update() {
        ProfessionRecord record = create.newRecord(PROFESSION);
        record.setDescription("QA")
                .store();

        LOGGER.debug("ID generated: {}", record.getProfessionId());

        var targetDescription = "Quality Assurance";
        record.setDescription(targetDescription)
                .store();

        String description = create.select(PROFESSION.DESCRIPTION)
                .from(PROFESSION)
                .where(PROFESSION.PROFESSION_ID.eq(record.getProfessionId()))
                .fetchOne(PROFESSION.DESCRIPTION);

        assertThat(description).isEqualTo(targetDescription);
    }

    @Test
    void test_record_delete() {
        ProfessionRecord record = create.newRecord(PROFESSION);
        record.setDescription("QA")
                .store();

        Integer id = record.getProfessionId();
        LOGGER.debug("ID generated: {}", id);

        record.delete();

        boolean exists = create.fetchExists(PROFESSION, PROFESSION.PROFESSION_ID.eq(id));

        assertFalse(exists);
    }

    @Test
    @Disabled
    void test_plain_jdbc() {
        executeUsingPlainJDBC(true, 1);
        executeUsingPlainJDBC(true, null);
        executeUsingPlainJDBC(false, null);
    }

    @Test
    void test_query_using_jooq() {
        executeUsingJOOQ(false, null);
        executeUsingJOOQ(true, null);
        executeUsingJOOQ(false, 1);
        executeUsingJOOQ(true, 1);
    }

    @Test
    void test_offset_pagination_with_jooq() {
        List<Integer> firstPage = create.selectFrom(TALK)
                .orderBy(TALK.EVENT_ID,
                        TALK.TALK_ID)
                .limit(5)
                .fetch(TALK.TALK_ID);

        assertThat(firstPage).isNotEmpty();

        List<Integer> secondPage = create.selectFrom(TALK)
                .orderBy(TALK.EVENT_ID)
                .limit(5)
                .offset(5)
                .fetch(TALK.TALK_ID);

        assertThat(secondPage).isNotEmpty();

        boolean duplicate = firstPage.stream()
                .anyMatch(id -> secondPage.contains(id));
        assertThat(duplicate).isFalse();
    }

    @Test
    void test_keyset_pagination_with_jooq() {
        Result<TalkRecord> firstPage = create.selectFrom(TALK)
                .where(TALK.STATUS.eq("ENDED"))
                .orderBy(TALK.EVENT_ID.desc(), TALK.TALK_ID.asc())
                .limit(5)
                .fetch();

        assertThat(firstPage).isNotEmpty();

        TalkRecord last = firstPage.getLast();
        Integer eventId = last.getEventId();
        Integer talkId = last.getTalkId();

        Result<TalkRecord> secondPage = create.selectFrom(TALK)
                .where(TALK.STATUS.eq("ENDED"))
                .orderBy(TALK.EVENT_ID.desc(), TALK.TALK_ID.asc())
                .seek(eventId, talkId)
                .limit(5)
                .fetch();

        assertThat(secondPage).isNotEmpty();
    }

    private Integer createProfession(String description) {
        Integer id = create.insertInto(PROFESSION,
                        PROFESSION.DESCRIPTION)
                .values(description)
                .returningResult(PROFESSION.PROFESSION_ID)
                .fetchOne(PROFESSION.PROFESSION_ID);
        return id;
    }

    /**
     * LAST_TALK: there is an extra colon placed after the alias
     * endedTalks: the predicate has an extra 'AND'
     * speakerId: the predicate doesn't add a space at the end of the statement
     * order by: the alias 'FULLNAME' is misspelled, the correct vale is 'FULL_NAME'
     * The 2 predicates are completely optional: the parameters' index might change depending on how many predicates are added
     * LAST__TALK: when reading fields from the resultSet, this alias is not defined in the original query
     */
    private void executeUsingPlainJDBC(boolean endedTalks, Integer speakerId) {
        var sql = "SELECT " +
                "T.SPEAKER_ID, " +
                "CONCAT(A.NAME, ' ', A.LAST_NAME) AS FULL_NAME, " +
                "COUNT(*) AS EVENT_COUNT, " +
                "MIN(E.SCHEDULED_DATE) AS FIRST_TALK, " +
                "MAX(E.SCHEDULED_DATE) AS LAST_TALK, " +
                "FROM TALK T INNER JOIN EVENT E " +
                "ON T.EVENT_ID = E.EVENT_ID " +
                "INNER JOIN ATTENDEE A " +
                "ON T.SPEAKER_ID = A.ATTENDEE_ID " +
                "WHERE " +
                (endedTalks ? "AND T.STATUS = ? " : "") +
                (speakerId != null ? "AND T.SPEAKER_ID = ?"  : "") +
                "GROUP BY T.SPEAKER_ID " +
                "ORDER BY FULLNAME";

        List<Map<String, Object>> speakerStats = new ArrayList<>();
        try (Connection connection = dataSource.getConnection()) {
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                if (endedTalks) preparedStatement.setString(1, "ENDED");
                preparedStatement.setInt(2, speakerId);

                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    while (resultSet.next()) {
                        Map<String, Object> stat = new HashMap<>();
                        stat.put("speakerId", resultSet.getString("SPEAKER_ID"));
                        stat.put("fullname", resultSet.getString("FULL_NAME"));
                        stat.put("count", resultSet.getString("EVENT_COUNT"));
                        stat.put("firstTalk", resultSet.getDate("FIRST_TALK"));
                        stat.put("lastTalk", resultSet.getDate("LAST__TALK"));
                        speakerStats.add(stat);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            fail(e.getMessage());
        }

        System.out.println(speakerStats);
    }

    private void executeUsingJOOQ(boolean endedTalks, Integer speakerId) {
        Condition condition = noCondition();

        if (endedTalks) {
            condition = condition.and(TALK.STATUS.eq("ENDED"));
        }
        if (speakerId != null) {
            condition = condition.and(TALK.SPEAKER_ID.eq(speakerId));
        }

        Field<String> fullNameField = concat(ATTENDEE.NAME, inline(" "), ATTENDEE.LAST_NAME).as("FULL_NAME");

        List<SpeakerStat> stats = create.select(
                    TALK.SPEAKER_ID,
                    fullNameField,
                    count().as("EVENT_COUNT"),
                    min(EVENT.SCHEDULED_DATE).as("FIRST_TALK"),
                    max(EVENT.SCHEDULED_DATE).as("LAST_TALK"))
                .from(TALK)
                .innerJoin(EVENT)
                .on(TALK.EVENT_ID.eq(EVENT.EVENT_ID))
                .innerJoin(ATTENDEE)
                .on(TALK.SPEAKER_ID.eq(ATTENDEE.ATTENDEE_ID))
                .where(condition)
                .groupBy(TALK.SPEAKER_ID)
                .orderBy(fullNameField)
                .fetch()
                .map(mapping(SpeakerStat::new));

        assertThat(stats).isNotEmpty();
    }

    record SpeakerStat(Integer speakerId, String fullName, Integer count, LocalDate firstTalk, LocalDate lastTalk) {
    }
}

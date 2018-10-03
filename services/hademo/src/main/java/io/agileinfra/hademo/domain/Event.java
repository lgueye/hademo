package io.agileinfra.hademo.domain;

import io.agileinfra.hademo.dto.SensorState;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Index;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.time.Instant;

/**
 * Created by <a href="mailto:louis.gueye@domo-safety.com">Louis Gueye</a>.
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = {"sensorBusinessId", "timestamp"})
@Builder
@Entity
@Table(name = "events_timeline", indexes = {@Index(name = "idx_events_timeline_sbid_timestamp", columnList = "sensor_bid,timestamp"),
        @Index(name = "idx_events_timeline_sensor_bid", columnList = "sensor_bid"),
        @Index(name = "idx_events_timeline_timestamp", columnList = "timestamp")})
public class Event {
    @Id
    @Column(name = "bed_fact_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "inserted_at", columnDefinition = "BIGINT", nullable = false)
    @NotNull
    private Instant insertedAt;

    @Column(name = "timestamp", columnDefinition = "BIGINT", nullable = false)
    @NotNull
    private Instant timestamp;

    @Column(name = "sensor_bid", nullable = false)
    @NotNull
    @Size(max = 255)
    private String sensorBusinessId;

    @Column(length = 50, nullable = false)
    @Enumerated(EnumType.STRING)
    @NotNull
    private SensorState state;

}

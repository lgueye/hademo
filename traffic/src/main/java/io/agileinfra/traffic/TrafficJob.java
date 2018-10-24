package io.agileinfra.traffic;

import com.google.common.base.Joiner;
import com.google.common.base.Strings;
import io.agileinfra.traffic.dto.EventDTO;
import io.agileinfra.traffic.dto.SensorState;
import io.agileinfra.traffic.repository.SosRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;

import java.time.Instant;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;

/**
 * Created by <a href="mailto:louis.gueye@domo-safety.com">Louis Gueye</a>.
 */
@RequiredArgsConstructor
@Slf4j
public class TrafficJob implements CommandLineRunner {

    private final SosRepository primaryRepository;
    private final SosRepository fallbackRepository;

    @Override
    public void run(String... args) throws InterruptedException {
        final int delayBetweenEvents = 20000;
        final int delayBeforeFetch = 10000;
        final int retryDelay = 120000;
        while (true) {
            final String sensorBusinessId = Joiner.on("-").join("sbid", Strings.padStart(String.valueOf(ThreadLocalRandom.current().nextInt(1, 10001)), 5, '0'));

            if (primaryRepository.available()) {
                primaryRepository.create(EventDTO.builder().sensorBusinessId(sensorBusinessId).state(SensorState.off).timestamp(Instant.now()).build());
                Thread.sleep(delayBetweenEvents);
                primaryRepository.create(EventDTO.builder().sensorBusinessId(sensorBusinessId).state(SensorState.on).timestamp(Instant.now()).build());
                Thread.sleep(delayBeforeFetch);
                final List<EventDTO> events = primaryRepository.findAll();
                log.info(">> Posted to primary datacenter, current events count = {}", events.size());
            } else if (fallbackRepository.available()) {
                fallbackRepository.create(EventDTO.builder().sensorBusinessId(sensorBusinessId).state(SensorState.off).timestamp(Instant.now()).build());
                Thread.sleep(delayBetweenEvents);
                fallbackRepository.create(EventDTO.builder().sensorBusinessId(sensorBusinessId).state(SensorState.on).timestamp(Instant.now()).build());
                Thread.sleep(delayBeforeFetch);
                final List<EventDTO> events = fallbackRepository.findAll();
                log.info(">> Posted to fallback datacenter, current events count = {}", events.size());
            } else {
                log.warn("Neither primary, nor fallback repository is available, retrying in PT2M");
                Thread.sleep(retryDelay);
            }
        }
    }
}
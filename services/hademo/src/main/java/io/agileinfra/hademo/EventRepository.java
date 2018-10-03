package io.agileinfra.hademo;

import io.agileinfra.hademo.domain.Event;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by <a href="mailto:louis.gueye@domo-safety.com">Louis Gueye</a>.
 */
public interface EventRepository extends JpaRepository<Event, Long> {
}

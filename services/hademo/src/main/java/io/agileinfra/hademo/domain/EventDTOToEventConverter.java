package io.agileinfra.hademo.domain;

import io.agileinfra.hademo.dto.EventDTO;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

/**
 * Created by <a href="mailto:louis.gueye@domo-safety.com">Louis Gueye</a>.
 */
@Component
public class EventDTOToEventConverter implements Converter<EventDTO, Event> {
    @Override
    public Event convert(EventDTO source) {
        if (source == null) return null;
        return Event.builder().id(source.getId()).insertedAt(source.getInsertedAt()).sensorBusinessId(source.getSensorBusinessId()).state(source.getState()).timestamp(source.getTimestamp()).build();
    }
}

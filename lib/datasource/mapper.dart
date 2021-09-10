abstract class DomainMapper<Source, Domain>{

  Domain mapToDomain(Source source);

  Source mapFromDomain(Domain domain);

}

abstract class OneWay<I,O>{

  O mapToDomain(I input);


}
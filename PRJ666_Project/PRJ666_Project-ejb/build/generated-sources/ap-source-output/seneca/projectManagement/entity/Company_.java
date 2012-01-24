package seneca.projectManagement.entity;

import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import seneca.projectManagement.entity.Projects;
import seneca.projectManagement.entity.Users;

@Generated(value="EclipseLink-2.2.0.v20110202-r8913", date="2012-01-23T23:01:56")
@StaticMetamodel(Company.class)
public class Company_ { 

    public static volatile SingularAttribute<Company, Integer> companyid;
    public static volatile SingularAttribute<Company, Users> repid;
    public static volatile SingularAttribute<Company, String> companyphone;
    public static volatile CollectionAttribute<Company, Projects> projectsCollection;
    public static volatile SingularAttribute<Company, Short> projectstatus;
    public static volatile SingularAttribute<Company, String> companyname;

}
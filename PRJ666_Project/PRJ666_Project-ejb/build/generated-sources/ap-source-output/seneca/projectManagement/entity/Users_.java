package seneca.projectManagement.entity;

import javax.annotation.Generated;
import javax.persistence.metamodel.CollectionAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import seneca.projectManagement.entity.Company;
import seneca.projectManagement.entity.Projects;
import seneca.projectManagement.entity.Teams;

@Generated(value="EclipseLink-2.2.0.v20110202-r8913", date="2012-01-23T23:01:56")
@StaticMetamodel(Users.class)
public class Users_ { 

    public static volatile CollectionAttribute<Users, Teams> teamsCollection;
    public static volatile SingularAttribute<Users, String> useridentifier;
    public static volatile SingularAttribute<Users, String> useremail;
    public static volatile CollectionAttribute<Users, Projects> projectsCollection;
    public static volatile SingularAttribute<Users, Integer> userid;
    public static volatile SingularAttribute<Users, String> userlname;
    public static volatile CollectionAttribute<Users, Company> companyCollection;
    public static volatile SingularAttribute<Users, String> userfname;
    public static volatile SingularAttribute<Users, String> userrole;
    public static volatile SingularAttribute<Users, Short> accountstatus;
    public static volatile SingularAttribute<Users, String> password;

}
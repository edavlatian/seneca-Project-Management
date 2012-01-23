package seneca.projectManagement.entity;

import java.io.Serializable;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import seneca.projectManagement.entity.Teams;

@Generated(value="EclipseLink-2.2.0.v20110202-r8913", date="2012-01-23T16:07:53")
@StaticMetamodel(Teammember.class)
public class Teammember_ { 

    public static volatile SingularAttribute<Teammember, Short> teamleader;
    public static volatile SingularAttribute<Teammember, Teams> teamid;
    public static volatile SingularAttribute<Teammember, Integer> memberid;
    public static volatile SingularAttribute<Teammember, String> email;
    public static volatile SingularAttribute<Teammember, String> description;
    public static volatile SingularAttribute<Teammember, String> lastname;
    public static volatile SingularAttribute<Teammember, Serializable> image;
    public static volatile SingularAttribute<Teammember, String> firstname;

}
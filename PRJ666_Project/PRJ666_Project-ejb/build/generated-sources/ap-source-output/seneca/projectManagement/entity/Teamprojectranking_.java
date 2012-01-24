package seneca.projectManagement.entity;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import seneca.projectManagement.entity.Projects;
import seneca.projectManagement.entity.Teams;

@Generated(value="EclipseLink-2.2.0.v20110202-r8913", date="2012-01-23T23:01:56")
@StaticMetamodel(Teamprojectranking.class)
public class Teamprojectranking_ { 

    public static volatile SingularAttribute<Teamprojectranking, Integer> id;
    public static volatile SingularAttribute<Teamprojectranking, Teams> teamid;
    public static volatile SingularAttribute<Teamprojectranking, Projects> projectid;
    public static volatile SingularAttribute<Teamprojectranking, Short> ranking;
    public static volatile SingularAttribute<Teamprojectranking, Character> whoranked;

}
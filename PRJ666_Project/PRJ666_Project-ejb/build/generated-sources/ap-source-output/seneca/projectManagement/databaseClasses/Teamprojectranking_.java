package seneca.projectManagement.databaseClasses;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import seneca.projectManagement.databaseClasses.Projects;
import seneca.projectManagement.databaseClasses.Teams;

@Generated(value="EclipseLink-2.2.0.v20110202-r8913", date="2012-01-24T22:34:46")
@StaticMetamodel(Teamprojectranking.class)
public class Teamprojectranking_ { 

    public static volatile SingularAttribute<Teamprojectranking, Integer> id;
    public static volatile SingularAttribute<Teamprojectranking, Teams> teamid;
    public static volatile SingularAttribute<Teamprojectranking, Projects> projectid;
    public static volatile SingularAttribute<Teamprojectranking, Short> ranking;
    public static volatile SingularAttribute<Teamprojectranking, Character> whoranked;

}
using Microsoft.EntityFrameworkCore.Migrations;

namespace BaoDuongXeMay.Migrations
{
    public partial class tb_accessary : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "AccessaryID",
                table: "Vehicle",
                type: "int",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "Accessarys",
                columns: table => new
                {
                    AccessaryID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    AccessaryName = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Accessarys", x => x.AccessaryID);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Vehicle_AccessaryID",
                table: "Vehicle",
                column: "AccessaryID");

            migrationBuilder.AddForeignKey(
                name: "FK_Vehicle_Accessarys_AccessaryID",
                table: "Vehicle",
                column: "AccessaryID",
                principalTable: "Accessarys",
                principalColumn: "AccessaryID",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Vehicle_Accessarys_AccessaryID",
                table: "Vehicle");

            migrationBuilder.DropTable(
                name: "Accessarys");

            migrationBuilder.DropIndex(
                name: "IX_Vehicle_AccessaryID",
                table: "Vehicle");

            migrationBuilder.DropColumn(
                name: "AccessaryID",
                table: "Vehicle");
        }
    }
}

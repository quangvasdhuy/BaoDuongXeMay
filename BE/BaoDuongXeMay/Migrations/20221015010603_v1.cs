using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace BaoDuongXeMay.Migrations
{
    public partial class v1 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_User_Username",
                table: "User");

            migrationBuilder.DropPrimaryKey(
                name: "PK_DetailNAU",
                table: "DetailNAU");

            migrationBuilder.AlterColumn<string>(
                name: "Username",
                table: "User",
                type: "nvarchar(450)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(100)",
                oldMaxLength: 100);

            migrationBuilder.AlterColumn<string>(
                name: "Password",
                table: "User",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(250)",
                oldMaxLength: 250);

            migrationBuilder.AddColumn<Guid>(
                name: "IDDetailNAU",
                table: "DetailNAU",
                type: "uniqueidentifier",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.AddPrimaryKey(
                name: "PK_DetailNAU",
                table: "DetailNAU",
                column: "IDDetailNAU");

            migrationBuilder.CreateIndex(
                name: "IX_User_Username",
                table: "User",
                column: "Username",
                unique: true,
                filter: "[Username] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_DetailNAU_AccessaryID",
                table: "DetailNAU",
                column: "AccessaryID");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_User_Username",
                table: "User");

            migrationBuilder.DropPrimaryKey(
                name: "PK_DetailNAU",
                table: "DetailNAU");

            migrationBuilder.DropIndex(
                name: "IX_DetailNAU_AccessaryID",
                table: "DetailNAU");

            migrationBuilder.DropColumn(
                name: "IDDetailNAU",
                table: "DetailNAU");

            migrationBuilder.AlterColumn<string>(
                name: "Username",
                table: "User",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(450)",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Password",
                table: "User",
                type: "nvarchar(250)",
                maxLength: 250,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AddPrimaryKey(
                name: "PK_DetailNAU",
                table: "DetailNAU",
                columns: new[] { "AccessaryID", "UnitID", "VehicleID" });

            migrationBuilder.CreateIndex(
                name: "IX_User_Username",
                table: "User",
                column: "Username",
                unique: true);
        }
    }
}

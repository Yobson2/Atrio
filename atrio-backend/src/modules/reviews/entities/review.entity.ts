import { Entity, Column } from 'typeorm';
import { BaseEntity } from '@common/database/base.entity';

@Entity('reviews')
export class Review extends BaseEntity {
  @Column()
  salonId: string;

  @Column()
  clientId: string;

  @Column({ nullable: true })
  barberId: string;

  @Column({ nullable: true })
  bookingId: string;

  @Column({ type: 'smallint' })
  rating: number;

  @Column({ type: 'text', nullable: true })
  content: string;

  @Column({ default: false })
  isFlagged: boolean;

  @Column({ type: 'text', nullable: true })
  ownerReply: string;

  @Column({ type: 'timestamptz', nullable: true })
  repliedAt: Date;

  @Column({ type: 'timestamptz', nullable: true })
  deletedAt: Date;
}
